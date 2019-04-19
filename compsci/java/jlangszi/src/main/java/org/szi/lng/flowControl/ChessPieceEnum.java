package org.szi.lng.flowControl;

/**
 * Created with IntelliJ IDEA.
 * User: zimine
 * Date: 09/20/2012
 * Time: 6:20 PM
 * To change this template use File | Settings | File Templates.
 */
public class ChessPieceEnum {
    public static enum Figure {KING, QUEEN, ROOK, BISHOP, KNIGHT, PAWN};
    public static enum Color { WHITE, BLACK };

    private final Color color;
    private final Figure figure;

    public ChessPieceEnum(Color color, Figure figure) {
        this.color = color;
        this.figure = figure;
    }

    public Figure getFigure() {
        return this.figure;
    }

    public Color getColor() {
        return this.color;
    }

    public String toString() {
        return this.color + " " + this.figure;
    }
}
