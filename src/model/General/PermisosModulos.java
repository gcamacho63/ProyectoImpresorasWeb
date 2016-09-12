package model.General;

import java.io.Serializable;

public class PermisosModulos implements Serializable 
{
	private int idModulo;
	private String nombreModulo;
	private int idRol;
	private boolean permiso;
	public int getIdModulo() {
		return idModulo;
	}
	public void setIdModulo(int idModulo) {
		this.idModulo = idModulo;
	}
	public String getNombreModulo() {
		return nombreModulo;
	}
	public void setNombreModulo(String nombreModulo) {
		this.nombreModulo = nombreModulo;
	}
	public int getIdRol() {
		return idRol;
	}
	public void setIdRol(int idRol) {
		this.idRol = idRol;
	}
	public boolean isPermiso() {
		return permiso;
	}
	public void setPermiso(boolean permiso) {
		this.permiso = permiso;
	}
	public PermisosModulos(int idModulo, String nombreModulo, int idRol, boolean permiso) {
		super();
		this.idModulo = idModulo;
		this.nombreModulo = nombreModulo;
		this.idRol = idRol;
		this.permiso = permiso;
	}		
}
