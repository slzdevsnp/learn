package org.szi.boot.repository;//Created on 3/9/18

import org.springframework.data.jpa.repository.JpaRepository;
import org.szi.boot.model.Shipwreck;

public interface ShipwreckRepository extends JpaRepository<Shipwreck, Long>
{

}

