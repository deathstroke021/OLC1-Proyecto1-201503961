/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto;

/**
 *
 * @author Fernando Augusto
 */
public class Nodo {
    
    public Nodo hizq;
    public Nodo hder;
    public String valor;
    public int id;
    public String i;
    public String an;
    public String first;
    public String last;

    public Nodo(Nodo hizq, Nodo hder, String valor, int id, String i, String an, String first, String last) {
        this.hizq = hizq;
        this.hder = hder;
        this.valor = valor;
        this.id = id;
        this.i = i;
        this.an = an;
        this.first = first;
        this.last = last;
    }

    public Nodo getHizq() {
        return hizq;
    }

    public void setHizq(Nodo hizq) {
        this.hizq = hizq;
    }

    public Nodo getHder() {
        return hder;
    }

    public void setHder(Nodo hder) {
        this.hder = hder;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public String getI() {
        return i;
    }

    public void setI(String i) {
        this.i = i;
    }
    
    public String getAN() {
        return an;
    }

    public void setAN(String an) {
        this.an = an;
    }
    
    public String getFirst() {
        return first;
    }

    public void setFirst(String first) {
        this.first = first;
    }
    
    public String getLast() {
        return last;
    }

    public void setLast(String last) {
        this.last = last;
    }
    
    public String getCodigoInterno() {
        String etiqueta;
  
        if (hizq == null && hder == null) {
            etiqueta = "struct" + id + " [ label =\" {" + an + "|{" + first + "|" + valor+ "| " + last + "}|" + i + " } \"];\n";
        } else {
            etiqueta = "struct" + id + " [ label =\" {" + an + "|{" + first +" |" + valor+ "| " + last + "}|" + i + "} \"];\n";
        }
        if (hizq != null) {
            etiqueta = etiqueta + hizq.getCodigoInterno()
                    + "struct" + id + "->struct" + hizq.id + "\n";
        }
        if (hder != null) {
            etiqueta = etiqueta + hder.getCodigoInterno()
                    + "struct" + id + "->struct" + hder.id + "\n";
        }
        return etiqueta;
    }
    
}
