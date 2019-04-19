package org.szi.lng.concurrent.fileReaderProdCons;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: slava
 * Date: Apr 20, 2009
 * Time: 5:40:43 PM
 * To change this template use File | Settings | File Templates.
 */
public class TextBuffer {
    public List<String> buffer;
    public boolean isEof;

    public TextBuffer() {
        buffer = new LinkedList();
        isEof = false;
    }
}
