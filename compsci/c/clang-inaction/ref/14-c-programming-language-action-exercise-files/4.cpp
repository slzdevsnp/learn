#include <stdio.h>

class Connection
{
    int SomeState;
    
public:
    
    Connection()
    {
        SomeState = 0;
        
        printf("Connection constructor\n");
    }
    
    void Open(char * filename)
    {
        SomeState = 1;
    }

    void Execute(char * statement)
    {
    }

    void Close()
    {
        SomeState = 0;
    }
    
    ~Connection()
    {
        Close();
        
        printf("Connection destructor\n");
    }
};

int main()
{
    Connection db;
    db.Open("C:\\temp\\sample.db");
    db.Execute("create table Hens (Id int, Name text)");
}
















