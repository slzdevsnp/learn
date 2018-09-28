package org.szi.boot.controller;//Created on 3/8/18

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.szi.boot.model.Shipwreck;
import org.szi.boot.repository.ShipwreckRepository;

import java.util.List;


@RestController
@RequestMapping("api/v1/")
public class ShipWreckController
{

    // spring mvc code with annotations for spring integration

    @Autowired
    private ShipwreckRepository shipwreckRepository;


    @RequestMapping(value = "shipwrecks", method = RequestMethod.GET)
    public List<Shipwreck> list() {
        return shipwreckRepository.findAll();
    }

    @RequestMapping(value = "shipwrecks", method = RequestMethod.POST)
    public Shipwreck create(@RequestBody Shipwreck shipwreck) {
        return shipwreckRepository.saveAndFlush(shipwreck);
    }

    @RequestMapping(value = "shipwrecks/{id}", method=RequestMethod.GET)
    public Shipwreck get(@PathVariable Long id){
        return shipwreckRepository.findOne(id);
    }

    @RequestMapping(value = "shipwrecks/{id}", method=RequestMethod.PUT)
    public Shipwreck update(@PathVariable Long id, @RequestBody Shipwreck shipwreck){
        Shipwreck existingShipWreck = shipwreckRepository.findOne(id);
        BeanUtils.copyProperties(shipwreck, existingShipWreck);
        return shipwreckRepository.saveAndFlush(existingShipWreck);
    }

    @RequestMapping(value = "shipwrecks/{id}", method=RequestMethod.DELETE)
    public Shipwreck delete(@PathVariable Long id)
    {
        Shipwreck existingShipWreck = shipwreckRepository.findOne(id);
        shipwreckRepository.delete(existingShipWreck);
        return ShipwreckStub.delete(id);
    }

}
