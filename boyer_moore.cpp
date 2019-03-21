//sp-values, z-values and read_fasta_file were written by Andrew Smith, Professor, Instructor of MATH-578A
//rest was written by Peter Sarvari

#include <sys/stat.h> // to get filesize in *nix
#include <vector>
#include <string>
#include <iostream> //std::cout << l_vals << std::endl;#include <cstdlib>
#include <cstdlib>
#include <fstream>
#include <cassert>

using std::vector;
using std::string;
using std::cout;
using std::endl;

static void
read_fasta_file_and_concat(const string &filename, string &T) {

  struct stat st;
  stat(filename.c_str(), &st); // get filesize

  T.resize(st.st_size);
  std::ifstream in(filename, std::ios::binary);
  in.read(&T[0], st.st_size);
  in.close();

  // remove any lines starting with '>' and all newline characters
  string::iterator dest(T.begin());
  const string::const_iterator last(T.end());
  bool in_name_line = false;
  for (string::const_iterator first(T.begin()); first != last; ++first) {
    if (*first == '>')
      in_name_line = true;
    if (*first != '\n' && !in_name_line)
      *dest++ = *first;
    if (*first == '\n')
      in_name_line = false;
  }
  std::fill(dest, T.end(), '\0');
}

static size_t
match(const string &s, size_t q, size_t i) {
  while (i < s.length() && s[q] == s[i]) {
    ++q;
    ++i;
  }
  return q;
}

static void z_algo(const string& s, vector<size_t>& Z){

string the_case;
//cout << "k" << "\t" << "l" << "\t" << "r" << "\t" << "Z[k]" << endl;

size_t l = 0, r = 0;
  for (size_t k = 1; k < s.length(); ++k) {
    if (k >= r) { // Case 1: full comparison
      the_case = "1";
      Z[k] = match(s, 0, k);
      r = k + Z[k];
      l = k;
    }
    else { // Case 2: (we are inside a Z-box)
      const size_t k_prime = k - l;
      const size_t beta_len = r - k;
      if (Z[k_prime] < beta_len) { // Case 2a: stay inside Z-box
        the_case = "2a";
        Z[k] = Z[k_prime];
      }
      else { // Case 2b: need to match outside the Z-box
        the_case = "2b";
        Z[k] = match(s, beta_len, r);
        r = k + Z[k];
        l = k;
      }
    }
//    cout << k + 1 << "\t" << l + 1 << "\t" << r << "\t"
//         << Z[k] << "\t" << the_case << endl;
  }

}

static void gsr(const string& pattern, vector<size_t>& l_vals){

    int n = pattern.size();
    for (int i = 0; i < n; i++)
        l_vals[i] = 0;

    string reverse_pattern;

    for (int i=n-1; i>-1; i--){
        reverse_pattern.push_back(pattern[i]);
    }

    vector<size_t> Z(n);
    z_algo(reverse_pattern, Z);

    vector<size_t> N;

    for (int i=n-1; i>-1; i--){
        N.push_back(Z[i]);
    }


    for (int i=0, j = 0; j < n-1; j++){
        if (N[j] > 0){
            i = n-N[j];
            l_vals[i] = j;
        }
    }
}

static void
compute_prefix_function(const string &P, vector<size_t> &sp) {
  const size_t n = P.length();
  sp = vector<size_t>(n, 0);

  size_t k = 0;
  for (size_t i = 1; i < n; ++i) {

    while (k > 0 && P[k] != P[i])
      k = sp[k - 1];

    if (P[k] == P[i]) ++k;

    sp[i] = k;
  }
}

static void bcr(const string& pattern, vector< vector<size_t> >& lookup){
    const size_t n = pattern.length();

    for (int i = 0; i < n; i++){
        for (int j = 0; j<5; j++){
            lookup[j][i] = 0;
        }
    }


    for (int i = 0; i < n; i++){

        if (i>0){
            for (int j = 0; j<5; j++){
                lookup[j][i] = lookup[j][i-1];
            }
        }


        if (pattern[i]=='A'){
            lookup[0][i] = i;
        }
        else if (pattern[i]=='C'){
            lookup[1][i] = i;
        }
        else if (pattern[i]=='G'){
            lookup[2][i] = i;
        }
        else if (pattern[i]=='T'){
            lookup[3][i] = i;
        }
        else {
            lookup[4][i] = i;
        }
    }
}

static void bm(const string& pattern, const string& text, size_t& matches){
    const size_t n = pattern.length();
    const size_t m = text.length();
    vector<size_t> l_vals(n);
    vector<size_t> sp(n);
    vector < vector<size_t> > lookup(5,vector<size_t>(n));

    gsr(pattern, l_vals);
    compute_prefix_function(pattern, sp);
    size_t sp_n = sp[n-1];
    bcr(pattern, lookup);

    int k = n-1;
    int i;
    int h;
    int lookup_val;
    size_t bcrshift;
    size_t gsrshift;
    while (k<= m-1){
        i = n-1;
        h = k;
        while (i > -1 && pattern[i] == text[h]){
            i = i-1;
            h = h-1;
        }
        if (i == -1){
            matches = matches + 1;
            k = k+n-sp_n;
        }
        else{
            if (i == 0){
                lookup_val = 0;
            }
            else{
                if (text[h] == 'A'){
                    lookup_val = lookup[0][i-1];
                }
                else if (text[h] == 'C'){
                    lookup_val = lookup[1][i-1];
                }
                else if (text[h] == 'G'){
                    lookup_val = lookup[2][i-1];
                }
                else if (text[h] == 'T'){
                    lookup_val = lookup[3][i-1];
                }
                else {
                    lookup_val = lookup[4][i-1];
                }
            }
            if (lookup_val > 0){
                bcrshift = i-lookup_val;
            }
            else {
                bcrshift = i-lookup_val+1; //+1 bc indexing starts from 1
            }
            if (l_vals[i+1] > 0){
                gsrshift = n-l_vals[i+1]-1; //-1 bc indexing starts from 1
            }
            else {
                gsrshift = n-l_vals[i+1];
            }
            if (i<(n-1)){
                    if (gsrshift > bcrshift){
                        k = k+gsrshift;
                    }
                    else{
                        k = k+bcrshift;
                    }
            }
            else{
                k = k+bcrshift;
            }
        }
    }

}

int
main(int argc, const char * const argv[]) {

    if (argc != 3) {
    std::cerr << "usage: " << argv[0] << " <PATTERN> <TEXT>" << endl;
    return EXIT_FAILURE;
    }

    const string pattern(argv[1]), text_filename(argv[2]);

    // read the text from the specified file
    string text;
    read_fasta_file_and_concat(text_filename, text);
    size_t matches = 0;

    bm(pattern, text, matches);
    cout << endl << "Number of matches is: " << matches << endl;


return 0;
}
