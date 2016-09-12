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
public class Rol implements Serializable
{
    /**
	 * 
	 */
	private int idRol;
    private String nombre;
    private String descripcion;
    private int estado;

    public int getEstado() {
		return estado;
	}

	public void setEstado(int estado) {
		this.estado = estado;
	}

    
    public int getIdRol() 
    {
            return idRol;
    }
    public void setIdRol(int idRol) 
    {
            this.idRol = idRol;
    }
    public String getDescripcion() 
    {
            return descripcion;
    }
    public void setDescripcion(String descripcion) 
    {
            this.descripcion = descripcion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Rol(int idRol, String nombre, String descripcion) {
        this.idRol = idRol;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }
  
    public Rol(int idRol, String nombre, String descripcion, int estado) {
		super();
		this.idRol = idRol;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.estado = estado;
	}

	@Override
    public String toString() 
    {
        return nombre;
    }
    
    public static Rol[] ConsultarRoles(String clausula)
    {		
    	String campos="*";
    	String tabla="user_roles";
    	Object[][] rolesArray=ConexionDB.Consulta(campos, tabla, clausula);
    	Rol[] roles = new Rol[rolesArray.length];
    	for(int i=0;i<rolesArray.length;i++)
    	{
    		int id=(int) rolesArray[i][0];
    		String nombre=(String) rolesArray[i][1];
    		String descripcion=(String) rolesArray[i][2];
    		roles[i]= new Rol(id, nombre, descripcion);   		
    	}
    	return roles;    	
    }
}
