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
public class ModeloImpresora implements Serializable
{
    /**
	 * 
	 */
	private int id_modelo;
    private String nombre;
    private String descripcion;
    private int estado;

    public int getEstado() {
		return estado;
	}

	public void setEstado(int estado) {
		this.estado = estado;
	}

    public int getId_modelo() {
        return id_modelo;
    }

    public void setId_modelo(int id_modelo) {
        this.id_modelo = id_modelo;
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

    @Override
    public String toString() {
        return nombre;
    }

	public ModeloImpresora(int id_modelo, String nombre, String descripcion, int estado) {
		super();
		this.id_modelo = id_modelo;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.estado = estado;
	}

	public static ModeloImpresora[] Consultar(String clausula)
    {
		String campos="*";
    	String tabla="imp_modelos";
    	Object[][] array=ConexionDB.Consulta(campos, tabla, clausula);    	
    	if(array==null)
    	{  		
    		return null;
    	}	
    	ModeloImpresora[] objeto = new ModeloImpresora[array.length];   	
    	for(int i=0;i<array.length;i++)
    	{
    		int id=(int) array[i][0];
    		String nombre=(String) array[i][1];
    		String descripcion=(String) array[i][2];
    		int estado=(int) array[i][3];
    		objeto[i]= new ModeloImpresora(id, nombre, descripcion,estado);   		
    	}
		return objeto;   	   	  	  	
    }  
}
