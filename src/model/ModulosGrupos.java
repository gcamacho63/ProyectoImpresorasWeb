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
public class ModulosGrupos implements Serializable
{
    /**
	 * 
	 */
	private int id_grupo;
    private String nombre;
    private String descripcion;
    private String carpeta;
    private int estado;

    public String getCarpeta() {
		return carpeta;
	}

	public void setCarpeta(String carpeta) {
		this.carpeta = carpeta;
	}

	public int getEstado() {
		return estado;
	}

	public void setEstado(int estado) {
		this.estado = estado;
	}


    public int getId_grupo() {
        return id_grupo;
    }

    public void setId_grupo(int id_grupo) {
        this.id_grupo = id_grupo;
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

    public ModulosGrupos(int id_grupo, String nombre, String descripcion) {
        this.id_grupo = id_grupo;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

	public ModulosGrupos(int id_grupo, String nombre, String descripcion, String carpeta, int estado) {
		super();
		this.id_grupo = id_grupo;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.carpeta = carpeta;
		this.estado = estado;
	}

	public static ModulosGrupos[] ConsultarGrupos(String clausula)
    {		
    	String campos="*";
    	String tabla="gen_modulos_grupos";
    	Object[][] gruposArray=ConexionDB.Consulta(campos, tabla, clausula);
    	ModulosGrupos[] grupos = new ModulosGrupos[gruposArray.length];
    	for(int i=0;i<gruposArray.length;i++)
    	{
    		int idGrupo = (int) gruposArray[i][0];
    		String nombre=(String) gruposArray[i][1];
    		String descripcion=(String) gruposArray[i][2];
    		grupos[i]= new ModulosGrupos(idGrupo, nombre, descripcion);   		
    	}
    	return grupos;    	
    }   
}
