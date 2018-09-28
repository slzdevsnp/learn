package org.szi.boot;//Created on 3/9/18

import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.szi.boot.controller.ShipWreckController;
import org.szi.boot.model.Shipwreck;
import org.szi.boot.repository.ShipwreckRepository;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import static org.mockito.Mockito.*;

public class ShipWreckControllerTest
{
    @InjectMocks
    private ShipWreckController sc;

    @Mock
    private ShipwreckRepository shipwreckRepository;

    @Before
    public void init() {   //method executes before any test methods
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testShipwreckGet(){

        Shipwreck sw = new Shipwreck();
        sw.setId(1L);
        when(shipwreckRepository.findOne(1L)).thenReturn(sw); // mocks the data from db


        Shipwreck wreck = sc.get(1L); // get the first ship

        verify(shipwreckRepository).findOne(1L);

        //assertEquals(1L, wreck.getId().longValue());
        assertThat(wreck.getId(), is(1L));
    }
}
