package org.szi.lrn.m4_5_implment_intf_in_dif_modules;//Created on 3/5/18

public interface ClientEngagementRepository extends AutoCloseable
{

    int NO_ID = 0;

    void add(ClientEngagement clientEngagement) throws RepositoryException ; //throw api exception

    void remove(ClientEngagement engagementToRemove) throws RepositoryException ;

    Iterable<ClientEngagement> find(Query query) throws RepositoryException;
}
