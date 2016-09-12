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
public class Area implements Serializable
{
    /**
	 * 
	 */
	private int idArea;
    private String nombreArea;
    private String descripcion;
    private int estado;

    public int getEstado() {
		return estado;
	}

	public void setEstado(int estado) {
		this.estado = estado;
	}

    public Area(int idArea, String nombreArea, String descripcion, int estado) {
		super();
		this.idArea = idArea;
		this.nombreArea = nombreArea;
		this.descripcion = descripcion;
		this.estado = estado;
	}

	public int getIdArea() {
            return idArea;
    }
    public void setIdArea(int idArea) {
            this.idArea = idArea;
    }
    public String getNombreArea() {
            return nombreArea;
    }
    public void setNombreArea(String nombreArea) {
            this.nombreArea = nombreArea;
    }
    
    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    @Override
    public String toString() 
    {
            return nombreArea;
    }
    public static Area[] Consultar(String clausula)
    {
		String campos="*";
    	String tabla="user_areas";
    	Object[][] array=ConexionDB.Consulta(campos, tabla, clausula);    	
    	if(array==null)
    	{  		
    		return null;
    	}	
    	Area[] objeto = new Area[array.length];   	
    	for(int i=0;i<array.length;i++)
    	{
    		int id=(int) array[i][0];
    		String nombre=(String) array[i][1];
    		String descripcion=(String) array[i][2];
    		int estado=(int) array[i][3];
    		objeto[i]= new Area(id, nombre, descripcion,estado);   		
    	}
		return objeto;   	   	  	  	
    }  
}
