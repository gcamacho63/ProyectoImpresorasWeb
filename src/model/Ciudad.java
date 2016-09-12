package model;

import java.io.Serializable;

public class Ciudad implements Serializable
{
	private int id_ciudad;
	private String nombre_ciudad;
	private int id_departamento;
	private String nombre_departamento;
	public int getId_ciudad() {
		return id_ciudad;
	}
	public void setId_ciudad(int id_ciudad) {
		this.id_ciudad = id_ciudad;
	}
	public String getNombre_ciudad() {
		return nombre_ciudad;
	}
	public void setNombre_ciudad(String nombre_ciudad) {
		this.nombre_ciudad = nombre_ciudad;
	}
	public int getId_departamento() {
		return id_departamento;
	}
	public void setId_departamento(int id_departamento) {
		this.id_departamento = id_departamento;
	}
	public String getNombre_departamento() {
		return nombre_departamento;
	}
	public void setNombre_departamento(String nombre_departamento) {
		this.nombre_departamento = nombre_departamento;
	}
	public Ciudad(int id_ciudad, String nombre_ciudad, int id_departamento, String nombre_departamento) {
		super();
		this.id_ciudad = id_ciudad;
		this.nombre_ciudad = nombre_ciudad;
		this.id_departamento = id_departamento;
		this.nombre_departamento = nombre_departamento;
	}
	
	public static Ciudad[] Consultar(String clausula)
    {
		String campos="*";
    	String tabla="gen_ciudades ciu LEFT JOIN gen_departamentos dep ON dep.id_departamento = ciu.departamento";
    	Object[][] array=ConexionDB.Consulta(campos, tabla, clausula);    	
    	if(array==null)
    	{  		
    		return null;
    	}	
    	Ciudad[] objeto = new Ciudad[array.length];   	
    	for(int i=0;i<array.length;i++)
    	{
    		int id=(int) array[i][0];
    		String nombre=(String) array[i][1];
    		int idDep=(int) array[i][2];
    		String nombreDep=(String) array[i][4];
    		objeto[i]= new Ciudad(id, nombre, idDep,nombreDep);   		
    	}
		return objeto;   	   	  	  	
    }  
}
