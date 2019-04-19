package org.szi.lng.concurrent.marakana;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/25/2012
 * Time: 10:25 AM
 * To change this template use File | Settings | File Templates.
 */


public class BlockingMap<K,V> {
    private Map<K,V> map =  new HashMap<K, V>();
    private ReadWriteLock lock = new ReentrantReadWriteLock();    //special lock object
    private Condition vAdded = lock.writeLock().newCondition();

    public V get(K key) {
        lock.readLock().lock();      //  lock
        try {
            return map.get(key);
        } finally {
            lock.readLock().unlock();        //unlock
        }
    }
    public V require(K key) {
        V value = get(key); // try cheap first
        if (value == null) {
            lock.writeLock().lock();                 //lock
            try {
                while((value = map.get(key)) == null) {
                    vAdded.await();
                }
            } catch (InterruptedException giveup) {

            } finally {
                lock.writeLock().unlock();                //unlock
            }
        }
        return value;
    }
    public void set(K key, V value) {
        lock.writeLock().lock();   //lock
        try {
            map.put(key, value);
            vAdded.signalAll();
        } finally {
            lock.writeLock().unlock();   //unlock
        }
    }
}