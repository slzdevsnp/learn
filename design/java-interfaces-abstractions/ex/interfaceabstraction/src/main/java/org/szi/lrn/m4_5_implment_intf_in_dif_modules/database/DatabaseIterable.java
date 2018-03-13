package org.szi.lrn.m4_5_implment_intf_in_dif_modules.database;//Created on 3/5/18
import org.szi.lrn.m4_5_implment_intf_in_dif_modules.ClientEngagement;

import java.sql.ResultSet;
import java.util.Iterator;

public class DatabaseIterable implements Iterable<ClientEngagement>
{
    private ResultSet resultSet;

    public DatabaseIterable(final ResultSet resultSet)
    {
        this.resultSet = resultSet;
    }

    @Override
    public Iterator<ClientEngagement> iterator()
    {
        return new DatabaseIterator(resultSet);
    }
}
