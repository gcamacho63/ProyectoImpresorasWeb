/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Alejandro
 */
public class Incidencia implements Serializable
{
    /**
	 * 
	 */
	private int id_incidencia;
    private int id_impresora;
    private String serial_imp;
    private int id_solicitante;
    private String nombre_solicitante;
    private int id_encargado;
    private String nombre_encargado;
    private int id_tipificacion;
    private String nombre_tipificacion;
    private Timestamp fecha_guardado;
    private int anio;
    private int mes;
    private Timestamp fecha_maxima;
    private int id_area;
    private String prioridad;
    private String descripcion;
    private String solucion;
    private String nombre_area;
    private int estadoActual;
    private String nombre_estado;
    private int tiempo_atencion;
    
    
    public int getTiempo_atencion() {
		return tiempo_atencion;
	}

	public void setTiempo_atencion(int tiempo_atencion) {
		this.tiempo_atencion = tiempo_atencion;
	}

	public String getNombre_estado() {
		return nombre_estado;
	}

	public void setNombre_estado(String nombre_estado) {
		this.nombre_estado = nombre_estado;
	}

	public Timestamp getFecha_maxima() {
		return fecha_maxima;
	}

	public void setFecha_maxima(Timestamp fecha_maxima) {
		this.fecha_maxima = fecha_maxima;
	}

	public int getEstadoActual() {
		return estadoActual;
	}

	public void setEstadoActual(int estadoActual) {
		this.estadoActual = estadoActual;
	}

	public int getAnio() {
		return anio;
	}

	public void setAnio(int anio) {
		this.anio = anio;
	}

	public int getMes() {
		return mes;
	}

	public void setMes(int mes) {
		this.mes = mes;
	}

	public String getNombre_area() {
		return nombre_area;
	}

	public void setNombre_area(String nombre_area) {
		this.nombre_area = nombre_area;
	}

	public int getId_incidencia() {
        return id_incidencia;
    }

    public void setId_incidencia(int id_incidencia) {
        this.id_incidencia = id_incidencia;
    }

    public int getId_impresora() {
        return id_impresora;
    }

    public void setId_impresora(int id_impresora) {
        this.id_impresora = id_impresora;
    }

    public String getSerial_imp() {
        return serial_imp;
    }

    public void setSerial_imp(String serial_imp) {
        this.serial_imp = serial_imp;
    }

    public int getId_solicitante() {
        return id_solicitante;
    }

    public void setId_solicitante(int id_solicitante) {
        this.id_solicitante = id_solicitante;
    }

    public String getNombre_solicitante() {
        return nombre_solicitante;
    }

    public void setNombre_solicitante(String nombre_solicitante) {
        this.nombre_solicitante = nombre_solicitante;
    }

    public int getId_encargado() {
        return id_encargado;
    }

    public void setId_encargado(int id_encargado) {
        this.id_encargado = id_encargado;
    }

    public String getNombre_encargado() {
        return nombre_encargado;
    }

    public void setNombre_encargado(String nombre_encargado) {
        this.nombre_encargado = nombre_encargado;
    }

    public int getId_tipificacion() {
        return id_tipificacion;
    }

    public void setId_tipificacion(int id_tipificacion) {
        this.id_tipificacion = id_tipificacion;
    }

    public String getNombre_tipificacion() {
        return nombre_tipificacion;
    }

    public void setNombre_tipificacion(String nombre_tipificacion) {
        this.nombre_tipificacion = nombre_tipificacion;
    }  
    public Timestamp getFecha_guardado() {
		return fecha_guardado;
	}

	public void setFecha_guardado(Timestamp fecha_guardado) {
		this.fecha_guardado = fecha_guardado;
	}

	

	public int getId_area() {
		return id_area;
	}

	public void setId_area(int id_area) {
        this.id_area = id_area;
    }

    public String getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(String prioridad) {
        this.prioridad = prioridad;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getSolucion() {
        return solucion;
    }

    public void setSolucion(String solucion) {
        this.solucion = solucion;
    }

	public Incidencia(int id_incidencia, int id_impresora, String serial_imp, int id_solicitante,
			String nombre_solicitante, int id_encargado, String nombre_encargado, int id_tipificacion,
			String nombre_tipificacion, Timestamp fecha_guardado, Timestamp fecha_maxima, int id_area ,String nombre_area,
			String prioridad,String descripcion, String solucion,int anio,int mes,int estadoActual,String nombre_estado,int tiempo_atencion) {
		super();
		this.id_incidencia = id_incidencia;
		this.id_impresora = id_impresora;
		this.serial_imp = serial_imp;
		this.id_solicitante = id_solicitante;
		this.nombre_solicitante = nombre_solicitante;
		this.id_encargado = id_encargado;
		this.nombre_encargado = nombre_encargado;
		this.id_tipificacion = id_tipificacion;
		this.nombre_tipificacion = nombre_tipificacion;
		this.fecha_guardado = fecha_guardado;
		this.fecha_maxima = fecha_maxima;
		this.id_area = id_area;
		this.nombre_area=nombre_area;
		this.prioridad = prioridad;
		this.descripcion = descripcion;
		this.solucion = solucion;
		this.anio=anio;
		this.mes=mes;
		this.estadoActual=estadoActual;
		this.nombre_estado=nombre_estado;
		this.tiempo_atencion=tiempo_atencion;
	}   
		 	 
	 public static Incidencia[] Consultar(String clausula)
     {
		String campos;
    	campos ="id_incidencias,imp.id_impresora,imp.serial,us.id_usuario,us.usuario,usA.id_usuario AS idEncaragdo,";
    	campos +="usA.usuario AS encargado,tip.id_tipificacion,tip.nombre_tipificacion,fecha_guardado,fecha_maxima,";
    	campos +="areas.id_area,areas.nombre_area,prioridad,inc.descripcion,solucion,anio,mes,estadoActual,est.nombre_estado,inc.tiempo_atencion";
    	String tabla="inc_incidencias inc ";
    	String join;
    	join = "LEFT JOIN imp_impresoras imp ON imp.id_impresora = inc.id_impresora ";
    	join +="LEFT JOIN user_usuarios us ON us.id_usuario = inc.usuario_solicitante ";
    	join +="LEFT JOIN user_usuarios usA ON usA.id_usuario = inc.usuario_encargado ";
    	join +="LEFT JOIN inc_tipificacion tip ON tip.id_tipificacion = inc.tipificacion ";
    	join +="LEFT JOIN user_areas areas ON areas.id_area = inc.area ";
    	join +="LEFT JOIN inc_estados est ON est.id_estado = inc.estadoActual";
    	Object[][] array=ConexionDB.Consulta(campos, tabla+join, clausula);    	
    	if(array==null)
    	{  		
    		return null;
    	}	
    	Incidencia[] objeto = new Incidencia[array.length];   	
    	for(int i=0;i<array.length;i++)
    	{
    		int id=(int) array[i][0];
    		int idImpresora=(int) array[i][1];
    		String serial=(String) array[i][2];
    		int idUsuario=(int) array[i][3];
    		String usuario=(String) array[i][4];
    		int idEncargado=(int) array[i][5];
    		String encargado=(String) array[i][6];
    		int idTipificacion=(int) array[i][7];
    		String tipificacion= (String) array[i][8];
    		Timestamp fechaini= (Timestamp) array[i][9];
    		Timestamp fechafin= (Timestamp) array[i][10];
    		int idArea=(int) array[i][11];
    		String nombreArea= (String) array[i][12];
    		String prioridad= (String) array[i][13];
    		String descripcion= (String) array[i][14];
    		String solucion= (String) array[i][15];
    		int anio=(int) array[i][16];
    		int mes=(int) array[i][17];
    		int estado=(int) array[i][18];
    		String nombre_estado= (String) array[i][19];
    		int tiempo_atencion=(int)array[i][20];
    		objeto[i]= new Incidencia(id, idImpresora, serial, idUsuario, usuario, idEncargado, encargado, idTipificacion, tipificacion, fechaini, fechafin, idArea, nombreArea, prioridad, descripcion, solucion,anio,mes,estado,nombre_estado,tiempo_atencion);  		  		
    	}
		return objeto;   	   	  	  	
    } 
}
