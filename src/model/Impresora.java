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
public class Impresora implements Serializable
{
    /**
	 * 
	 */
	private int id_impresora;
    private String serial;
    private int modelo;
    private String nombre_modelo;
    private int ciudad;
    private String nombre_ciudad;
    private int area;
    private String nombre_area;
    private int estado;

    public int getEstado() {
		return estado;
	}

	public void setEstado(int estado) {
		this.estado = estado;
	}

    public int getId_impresora() {
        return id_impresora;
    }

    public void setId_impresora(int id_impresora) {
        this.id_impresora = id_impresora;
    }

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    public int getModelo() {
        return modelo;
    }

    public void setModelo(int modelo) {
        this.modelo = modelo;
    }

    public String getNombre_modelo() {
        return nombre_modelo;
    }

    public void setNombre_modelo(String nombre_modelo) {
        this.nombre_modelo = nombre_modelo;
    }

    public int getCiudad() {
        return ciudad;
    }

    public void setCiudad(int ciudad) {
        this.ciudad = ciudad;
    }

    public String getNombre_ciudad() {
        return nombre_ciudad;
    }

    public void setNombre_ciudad(String nombre_ciudad) {
        this.nombre_ciudad = nombre_ciudad;
    }

    public int getArea() {
        return area;
    }

    public void setArea(int area) {
        this.area = area;
    }

    public String getNombre_area() {
        return nombre_area;
    }

    public void setNombre_area(String nombre_area) {
        this.nombre_area = nombre_area;
    }

    @Override
    public String toString() 
    {
            return nombre_area +"-"+serial;
    }

	public Impresora(int id_impresora, String serial, int modelo, String nombre_modelo, int ciudad,
			String nombre_ciudad, int area, String nombre_area, int estado) {
		super();
		this.id_impresora = id_impresora;
		this.serial = serial;
		this.modelo = modelo;
		this.nombre_modelo = nombre_modelo;
		this.ciudad = ciudad;
		this.nombre_ciudad = nombre_ciudad;
		this.area = area;
		this.nombre_area = nombre_area;
		this.estado = estado;
	}
	
	public static Impresora[] Consultar(String clausula,String addJoin)
    {
		String campos="id_impresora,imp.serial,modelo,nombre_modelo,id_ciudad,nombre_ciudad,id_area,nombre_area,imp.estado";
    	String tabla="imp_impresoras imp ";
    	String join="LEFT JOIN user_areas areas ON imp.area = areas.id_area ";
    	join +="LEFT JOIN imp_modelos model ON model.id_modelo = imp.modelo ";
    	join +="LEFT JOIN gen_ciudades ciu ON ciu.id_ciudad = imp.ciudad ";
    	Object[][] array=ConexionDB.Consulta(campos, tabla+join+""+addJoin, clausula);    	
    	if(array==null)
    	{  		
    		return null;
    	}	
    	Impresora[] objeto = new Impresora[array.length];   	
    	for(int i=0;i<array.length;i++)
    	{
    		int id=(int) array[i][0];
    		String serial=(String) array[i][1];
    		int modelo=(int) array[i][2];
    		String nombre_modelo=(String) array[i][3];
    		int ciudad=(int) array[i][4];
    		String nombre_ciudad=(String) array[i][5];
    		int area=(int) array[i][6];
    		String nombre_area=(String) array[i][7];
    		int estado=(int) array[i][8];
    		objeto[i]= new Impresora(id, serial,modelo,nombre_modelo,ciudad,nombre_ciudad,area,nombre_area,estado);   		
    	}		
    	return objeto;	
    }      
}
