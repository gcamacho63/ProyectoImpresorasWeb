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
public class Modulo implements Serializable
{
    /**
	 * 
	 */
	private int id_modulo;
	private String nombre;
    private String descripcion;
    private String icono;
    private String archivo;
    private String carpeta;
    private String controlador;
    private int estado;

    public int getEstado() {
		return estado;
	}

	public void setEstado(int estado) {
		this.estado = estado;
	}

    public String getArchivo() {
		return archivo;
	}

	public void setArchivo(String archivo) {
		this.archivo = archivo;
	}

	public String getCarpeta() {
		return carpeta;
	}

	public void setCarpeta(String carpeta) {
		this.carpeta = carpeta;
	}

	private int grupo;
    
    private String nombre_grupo;

    public int getId_modulo() {
        return id_modulo;
    }

    public void setId_modulo(int id_modulo) {
        this.id_modulo = id_modulo;
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

    public String getIcono() {
        return icono;
    }

    public void setIcono(String icono) {
        this.icono = icono;
    }

    public int getGrupo() {
        return grupo;
    }

    public void setGrupo(int grupo) {
        this.grupo = grupo;
    }

    public String getNombre_grupo() {
        return nombre_grupo;
    }

    public void setNombre_grupo(String nombre_grupo) {
        this.nombre_grupo = nombre_grupo;
    }
    public String getControlador() {
		return controlador;
	}

	public void setControlador(String controlador) {
		this.controlador = controlador;
	}

	@Override
    public String toString() {
        return nombre;
    }
	public Modulo(int id_modulo, String nombre, String descripcion, String icono, String archivo, String carpeta,
			String controlador, int grupo, String nombre_grupo) {
		super();
		this.id_modulo = id_modulo;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.icono = icono;
		this.archivo = archivo;
		this.carpeta = carpeta;
		this.controlador = controlador;
		this.grupo = grupo;
		this.nombre_grupo = nombre_grupo;
	}

	public Modulo(int id_modulo, String nombre, String descripcion, String icono, String archivo, String carpeta,
			String controlador, int estado, int grupo, String nombre_grupo) {
		super();
		this.id_modulo = id_modulo;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.icono = icono;
		this.archivo = archivo;
		this.carpeta = carpeta;
		this.controlador = controlador;
		this.estado = estado;
		this.grupo = grupo;
		this.nombre_grupo = nombre_grupo;
	}	
	
	public static Modulo[] Consultar(String clausula)
    {
		String campos="m.id_modulo,m.nombre,m.descripcion,icono,archivo,carpeta,m.controlador,m.estado,grupo,nombre_grupo";
		String join="LEFT JOIN gen_modulos_grupos mg ON mg.id_grupo = m.grupo";
    	String tabla="gen_modulos m ";
    	Object[][] array=ConexionDB.Consulta(campos, tabla+join, clausula);    	
    	if(array==null)
    	{  		
    		return null;
    	}	
    	Modulo[] objeto = new Modulo[array.length];   	
    	for(int i=0;i<array.length;i++)
    	{
    		int id=(int) array[i][0];
    		String nombre=(String) array[i][1];
    		String descripcion=(String) array[i][2];
    		String icono=(String) array[i][3];
    		String archivo= (String) array[i][4];
    		String carpeta= (String) array[i][5];
    		String controlador= (String) array[i][6];
    		int estado=(int) array[i][7];
    		int grupo= (int) array[i][8];
    		String nombreGrupo= (String) array[i][9];
    		objeto[i]= new Modulo(id, nombre, descripcion, icono, archivo, carpeta, controlador, estado, grupo, nombreGrupo);  		  		
    	}
		return objeto;   	   	  	  	
    } 
}
