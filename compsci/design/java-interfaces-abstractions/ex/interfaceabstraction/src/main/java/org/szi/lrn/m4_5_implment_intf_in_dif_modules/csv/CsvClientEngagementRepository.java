package org.szi.lrn.m4_5_implment_intf_in_dif_modules.csv;//Created on 3/5/18

import org.szi.lrn.m4_5_implment_intf_in_dif_modules.ClientEngagement;
import org.szi.lrn.m4_5_implment_intf_in_dif_modules.ClientEngagementRepository;
import org.szi.lrn.m4_5_implment_intf_in_dif_modules.RepositoryException;
import org.szi.lrn.m4_5_implment_intf_in_dif_modules.Query;

import java.util.List;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class CsvClientEngagementRepository implements ClientEngagementRepository
{

    private final List<ClientEngagement> engagements;
    private final CsvPersistor persistor;

    private int nextId = 1;

    public CsvClientEngagementRepository(final String path)
    {
        persistor = new CsvPersistor(path);
        engagements = persistor.load(); //fill up the list for csv file
    }



    @Override
    public void add(ClientEngagement clientEngagement) throws RepositoryException
    {
        if (clientEngagement.getId() == NO_ID)
        {
            engagements.add(clientEngagement);
            clientEngagement.setId(nextId++);
        }

    }

    @Override
    public void remove(ClientEngagement engagementToRemove) throws RepositoryException
    {
        if (engagements.removeIf(engagement -> engagement.getId() == engagementToRemove.getId()))
        {
            engagementToRemove.setId(NO_ID);
        }
    }

    @Override
    public Iterable<ClientEngagement> find(Query query) throws RepositoryException
    {
        return engagements.stream().filter(filterOf(query)).collect(Collectors.toList());
    }


    private Predicate<? super ClientEngagement> filterOf(final Query query)
    {
        final String client = query.getClient();
        return engagement -> engagement.getHoursWorked() >= query.getAtLeastHoursWorked() &&
                (client == null || engagement.getClient().equals(client));
    }

    @Override
    public void close() throws Exception
    {
        persistor.save(engagements);
    }

}
