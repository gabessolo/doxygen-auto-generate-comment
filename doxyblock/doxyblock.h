  
#include <stdio.h>  
#include <unistd.h>  
#include <string>  
#include <sstream>  

using namespace std;

#define MAX_LINE    1024
#define NB_NODE_MAX 1024

typedef struct node 
{
  stringstream line;
  node* next;
  node* prev;
} node;


void usage();
void addblock(char* filename);
void fixblock(char* filename);
int readline(FILE* id,char* line ); 
string  new_filename(char* filename);

