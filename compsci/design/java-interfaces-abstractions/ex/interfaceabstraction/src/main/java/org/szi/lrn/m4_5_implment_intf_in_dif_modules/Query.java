package org.szi.lrn.m4_5_implment_intf_in_dif_modules;//Created on 3/5/18

public class Query
{

    private String client;
    private int atLeastHoursWorked;

    public Query client(final String client)
    {
        this.client = client;

        return this;
    }

    public Query atLeastHoursWorked(final int atLeastHoursWorked)
    {
        this.atLeastHoursWorked = atLeastHoursWorked;

        return this;
    }

    public String getClient()
    {
        return client;
    }

    public int getAtLeastHoursWorked()
    {
        return atLeastHoursWorked;
    }

    @Override
    public String toString()
    {
        return "Query{" +
                "client='" + client + '\'' +
                ", atLeastHoursWorked=" + atLeastHoursWorked +
                '}';
    }
}
