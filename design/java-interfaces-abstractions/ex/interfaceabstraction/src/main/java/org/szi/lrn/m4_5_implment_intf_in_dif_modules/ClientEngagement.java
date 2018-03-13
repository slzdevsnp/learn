package org.szi.lrn.m4_5_implment_intf_in_dif_modules;//Created on 3/5/18

public class ClientEngagement
{

    private int id;
    private final String client;
    private final int hoursWorked;

    public ClientEngagement(final String client, final int hoursWorked)
    {
        this.client = client;
        this.hoursWorked = hoursWorked;
    }

    public String getClient()
    {
        return client;
    }

    public int getHoursWorked()
    {
        return hoursWorked;
    }

    public int getId()
    {
        return id;
    }

    public void setId(final int id)
    {
        this.id = id;
    }

    @Override
    public String toString()
    {
        return "ClientEngagement{" +
                "id=" + id +
                ", client='" + client + '\'' +
                ", hoursWorked=" + hoursWorked +
                '}';
    }
}
