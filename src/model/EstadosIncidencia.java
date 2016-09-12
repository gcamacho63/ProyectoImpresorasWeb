package model;

import java.io.Serializable;
import java.sql.Timestamp;


public class EstadosIncidencia implements Serializable
{
	private int idIncidencia;
	private int idEstado;
	private String nombreEstado;
	private String comentario;
	private Timestamp fechaGuardado;
	public int getIdIncidencia() {
		return idIncidencia;
	}
	public void setIdIncidencia(int idIncidencia) {
		this.idIncidencia = idIncidencia;
	}
	public int getIdEstado() {
		return idEstado;
	}
	public void setIdEstado(int idEstado) {
		this.idEstado = idEstado;
	}
	public String getNombreEstado() {
		return nombreEstado;
	}
	public void setNombreEstado(String nombreEstado) {
		this.nombreEstado = nombreEstado;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}	
	public Timestamp getFechaGuardado() {
		return fechaGuardado;
	}
	public void setFechaGuardado(Timestamp fechaGuardado) {
		this.fechaGuardado = fechaGuardado;
	}
	public EstadosIncidencia(int idIncidencia, int idEstado, String nombreEstado, String comentario,
			Timestamp fechaGuardado) {
		super();
		this.idIncidencia = idIncidencia;
		this.idEstado = idEstado;
		this.nombreEstado = nombreEstado;
		this.comentario = comentario;
		this.fechaGuardado = fechaGuardado;
	}
	
	public static EstadosIncidencia[] Consultar(String clausula)
    {
		ConexionDB.conectarDB();
		String campos="incidencia,inc.estado,nombre_estado,comentario,fecha_guardado ";
		String join="LEFT JOIN inc_estados est ON est.id_estado = inc.estado ";
    	String tabla="inc_estados_incidencias inc ";
    	Object[][] array=ConexionDB.Consulta(campos, tabla+join, clausula);    	
    	if(array==null)
    	{  		
    		return null;
    	}	
    	EstadosIncidencia[] objeto = new EstadosIncidencia[array.length];   	
    	for(int i=0;i<array.length;i++)
    	{
    		int id=(int) array[i][0];
    		int estado=(int) array[i][1];
    		String nombre_estado=(String) array[i][2];
    		String comentario=(String) array[i][3];
    		Timestamp fecha=(Timestamp) array[i][4];
    		objeto[i]= new EstadosIncidencia(id, estado, nombre_estado, comentario, fecha);  		  		
    	}
		return objeto;   	   	  	  	
    } 
}
