package model;

import java.io.Serializable;
import java.sql.Timestamp;

public class TiempoAtencion implements Serializable
{
	private int id_tiempo;
    private int hora_inicio;
    private int hora_fin;
    private int tiempo_atencion;
    private int dia_inicio;
    private int dia_fin;
    private Timestamp fecha;
    
    public Timestamp getFecha() {
		return fecha;
	}
	public void setFecha(Timestamp fecha) {
		this.fecha = fecha;
	}
	public int getId_tiempo() {
		return id_tiempo;
	}
	public void setId_tiempo(int id_tiempo) {
		this.id_tiempo = id_tiempo;
	}
	public int getHora_inicio() {
		return hora_inicio;
	}
	public void setHora_inicio(int hora_inicio) {
		this.hora_inicio = hora_inicio;
	}
	public int getHora_fin() {
		return hora_fin;
	}
	public void setHora_fin(int hora_fin) {
		this.hora_fin = hora_fin;
	}
	public int getTiempo_atencion() {
		return tiempo_atencion;
	}
	public void setTiempo_atencion(int tiempo_atencion) {
		this.tiempo_atencion = tiempo_atencion;
	}
	public int getDia_inicio() {
		return dia_inicio;
	}
	public void setDia_inicio(int dia_inicio) {
		this.dia_inicio = dia_inicio;
	}
	public int getDia_fin() {
		return dia_fin;
	}
	public void setDia_fin(int dia_fin) {
		this.dia_fin = dia_fin;
	}
	public TiempoAtencion(int id_tiempo, int hora_inicio, int hora_fin, int tiempo_atencion, int dia_inicio,
			int dia_fin,Timestamp fecha) {
		super();
		this.id_tiempo = id_tiempo;
		this.hora_inicio = hora_inicio;
		this.hora_fin = hora_fin;
		this.tiempo_atencion = tiempo_atencion;
		this.dia_inicio = dia_inicio;
		this.dia_fin = dia_fin;
		this.fecha=fecha;
	}
    
	public static TiempoAtencion[] Consultar(String clausula)
    {
		String campos="*";
    	String tabla="inc_tiempos_atencion";
    	Object[][] array=ConexionDB.Consulta(campos, tabla, clausula);    	
    	if(array==null)
    	{  		
    		return null;
    	}	
    	TiempoAtencion[] objeto = new TiempoAtencion[array.length];   	
    	for(int i=0;i<array.length;i++)
    	{
    		int id=(int) array[i][0];
    		int hinicio=(int) array[i][1];
    		int hfin=(int) array[i][2];
    		int tiempo_atencion=(int) array[i][3];
    		int dia_inicio=(int) array[i][4];
    		int dia_fin=(int) array[i][5];
    		Timestamp fecha= (Timestamp)array[i][6];
    		objeto[i]= new TiempoAtencion (id, hinicio, hfin,tiempo_atencion,dia_inicio,dia_fin,fecha);   		
    	}
		return objeto;   	   	  	  	
    }  
}