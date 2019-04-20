package org.szi;

import static org.assertj.core.api.Assertions.*;
import org.junit.jupiter.api.Test;

class JUnit5BasicTest {


  @Test
    void justTestExample(){
      Boolean  b = true;
      String name = "mama";
      assertThat(b).isEqualTo(true);
      assertThat(name).contains("ma");
  }

  @Test
    void justEnotherExample(){
    assertThat(true).isEqualTo(true);
  }
}
