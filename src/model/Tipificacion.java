/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;

/**
 *
 * @author Alejandro
 */
public class Tipificacion implements Serializable
{
    private int id_tipificacion;
    private String nombre;
    private String descripcion;
    private int estado;

    public int getEstado() {
		return estado;
	}

	public void setEstado(int estado) {
		this.estado = estado;
	}

	@Override
    public String toString() {
        return nombre;            
    }
 

    public int getId_tipificacion() {
        return id_tipificacion;
    }

    public void setId_tipificacion(int id_tipificacion) {
        this.id_tipificacion = id_tipificacion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
       
    public Tipificacion(int id_tipificacion, String nombre, String descripcion, int estado) {
		super();
		this.id_tipificacion = id_tipificacion;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.estado = estado;
	}

	public static Tipificacion[] ConsultarTipificaciones(String clausula)
    {
    	String campos="*";
    	String tabla="inc_tipificacion";
    	Object[][] tipArray=ConexionDB.Consulta(campos, tabla, clausula);    	
    	if(tipArray==null)
    	{  		
    		return null;
    	}
    	Tipificacion[] tip = new Tipificacion[tipArray.length];
    	for(int i=0;i<tipArray.length;i++)
    	{
    		int id=(int) tipArray[i][0];
    		String nombre=(String) tipArray[i][1];
    		String descripcion=(String) tipArray[i][2];
    		int estado=(int) tipArray[i][3];
    		tip[i]= new Tipificacion(id, nombre, descripcion,estado);   		
    	}
		return tip;   	   	  	  	
    }   
	
	
}
