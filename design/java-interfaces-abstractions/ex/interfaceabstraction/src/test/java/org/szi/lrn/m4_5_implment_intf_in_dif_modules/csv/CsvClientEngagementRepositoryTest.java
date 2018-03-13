package org.szi.lrn.m4_5_implment_intf_in_dif_modules.csv;//Created on 3/5/18

import org.junit.Assert;
import org.szi.lrn.m4_5_implment_intf_in_dif_modules.ClientEngagement;
import org.szi.lrn.m4_5_implment_intf_in_dif_modules.ClientEngagementRepository;
import org.szi.lrn.m4_5_implment_intf_in_dif_modules.Query;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;

import org.junit.After;
import org.junit.Test;
import static org.junit.Assert.*;



public class CsvClientEngagementRepositoryTest
{
    private static final String PLURALSIGHT = "Pluralsight";

    private File file = File.createTempFile("database", "csv");
    private ClientEngagementRepository repository = new CsvClientEngagementRepository(file.getAbsolutePath());
    private ClientEngagement engagement = new ClientEngagement(PLURALSIGHT, 10);


    public CsvClientEngagementRepositoryTest() throws IOException
    {
        System.out.println("csv file created at: " + file.getAbsolutePath() );
    }


    @After
    public void tearDown() throws Exception
    {
        repository.close();
    }

    @Test
    public void shouldAddClientEngagement() throws Exception
    {
        repository.add(engagement);

        Assert.assertNotEquals(ClientEngagementRepository.NO_ID, engagement.getId());
    }


    @Test
    public void shouldRemoveClientEngagement() throws Exception
    {
        repository.add(engagement);

        repository.remove(engagement);

        Assert.assertEquals(ClientEngagementRepository.NO_ID, engagement.getId());
    }

    @Test
    public void shouldFindRelevantClientEngagements() throws Exception
    {
        repository.add(engagement);
        repository.add(new ClientEngagement("Foo", 20));
        repository.add(new ClientEngagement(PLURALSIGHT, 20));

        final Iterator<ClientEngagement> engagements =
                repository.find(new Query().atLeastHoursWorked(15).client(PLURALSIGHT)).iterator();

        assertTrue(engagements.hasNext());

        final ClientEngagement result = engagements.next();
        assertEquals(PLURALSIGHT, result.getClient());
        assertEquals(20, result.getHoursWorked());

        assertFalse(engagements.hasNext());
    }



}
