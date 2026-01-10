/*
interesting features of the shell:
input redirection
piping data from one program to another

cd changes the directory
./ runs a shell script/program
programs take arguments, read from standard input, and writes to standard output

./prog > output.txt 
sends the output from prog into output.txt (overwrites)

./prog < input.txt 
sends input.txt as input into prog

the standard input of one program can be the standard output of another program
./prog1 | ./prog2
the output of prog1 is fed into prog2 as input
make sure you're calling prog1 with the right arguments

course details:
cli git is used to manage and submit your assignments
repositories are setup on markus

textbooks:
 c programming by king
 the linux programming interface (optional)
*/

int main(){}
