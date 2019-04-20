#include <stdio.h>

struct Connection
{
    int SomeState;
    
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
    
};

int main()
{
    Connection db;
    db.Open("C:\\temp\\sample.db");
    db.Execute("create table Hens (Id int, Name text)");
    db.Close();
}
















