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
public class Usuario implements Serializable
{
    private int id_usuario;
    private String usuario;
    private int rol;
    private String nombreRol;
    private String contrasenia;
    private String nombre1;
    private String nombre2;
    private String apellido1;
    private String apellido2;
    private String cargo;
    private int area;
    private String nombre_area;
    private int ciudad;
    private String nombre_ciudad;   
    private String correo;
    private String extension;
    private String foto;
    private int estado;

    public int getEstado() {
		return estado;
	}

	public void setEstado(int estado) {
		this.estado = estado;
	}

    @Override
    public String toString() {
        return "Usuario{" + "usuario=" + usuario + '}';
    }

    public Usuario(int id_usuario, String usuario, int rol, String nombreRol, String contrasenia, String nombre1, 
            String nombre2, String apellido1, String apellido2, String cargo, int area, String nombre_area, 
            int ciudad, String nombre_ciudad, String correo, String extension,String foto) 
    {
        this.id_usuario = id_usuario;
        this.usuario = usuario;
        this.rol = rol;
        this.nombreRol = nombreRol;
        this.contrasenia = contrasenia;
        this.nombre1 = nombre1;
        this.nombre2 = nombre2;
        this.apellido1 = apellido1;
        this.apellido2 = apellido2;
        this.cargo = cargo;
        this.area = area;
        this.nombre_area = nombre_area;
        this.ciudad = ciudad;
        this.nombre_ciudad = nombre_ciudad;
        this.correo = correo;
        this.extension = extension;
        this.foto=foto;
    }
    
    public Usuario(int id_usuario, String usuario, int rol, String nombreRol, String contrasenia, String nombre1,
			String nombre2, String apellido1, String apellido2, String cargo, int area, String nombre_area, int ciudad,
			String nombre_ciudad, String correo, String extension, int estado) {
		super();
		this.id_usuario = id_usuario;
		this.usuario = usuario;
		this.rol = rol;
		this.nombreRol = nombreRol;
		this.contrasenia = contrasenia;
		this.nombre1 = nombre1;
		this.nombre2 = nombre2;
		this.apellido1 = apellido1;
		this.apellido2 = apellido2;
		this.cargo = cargo;
		this.area = area;
		this.nombre_area = nombre_area;
		this.ciudad = ciudad;
		this.nombre_ciudad = nombre_ciudad;
		this.correo = correo;
		this.extension = extension;
		this.estado = estado;
	}

    
	public String getFoto() {
		return foto;
	}

	public void setFoto(String foto) {
		this.foto = foto;
	}

	public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }

    public String getNombre1() {
        return nombre1;
    }

    public void setNombre1(String nombre1) {
        this.nombre1 = nombre1;
    }

    public String getNombre2() {
        return nombre2;
    }

    public void setNombre2(String nombre2) {
        this.nombre2 = nombre2;
    }

    public String getApellido1() {
        return apellido1;
    }

    public void setApellido1(String apellido1) {
        this.apellido1 = apellido1;
    }

    public String getApellido2() {
        return apellido2;
    }

    public void setApellido2(String apellido2) {
        this.apellido2 = apellido2;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
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

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    public int getRol() {
        return rol;
    }

    public void setRol(int rol) {
        this.rol = rol;
    }

    public String getNombreRol() {
        return nombreRol;
    }

    public void setNombreRol(String nombreRol) {
        this.nombreRol = nombreRol;
    }
       
    public Usuario(int id_usuario, String usuario, int rol, String nombreRol, String contrasenia, String nombre1,
			String nombre2, String apellido1, String apellido2, String cargo, int area, String nombre_area, int ciudad,
			String nombre_ciudad, String correo, String extension, String foto, int estado) {
		super();
		this.id_usuario = id_usuario;
		this.usuario = usuario;
		this.rol = rol;
		this.nombreRol = nombreRol;
		this.contrasenia = contrasenia;
		this.nombre1 = nombre1;
		this.nombre2 = nombre2;
		this.apellido1 = apellido1;
		this.apellido2 = apellido2;
		this.cargo = cargo;
		this.area = area;
		this.nombre_area = nombre_area;
		this.ciudad = ciudad;
		this.nombre_ciudad = nombre_ciudad;
		this.correo = correo;
		this.extension = extension;
		this.foto = foto;
		this.estado = estado;
	}

	public static Usuario[] Consultar(String clausula)
    {
    	ConexionDB.conectarDB();
		String campos="id_usuario,usuario,rol_usuario,nombre_rol,contrasenia,nombre1,nombre2,apellido1,apellido2,cargo,area,nombre_area,";
    	campos +="ciu.id_ciudad,nombre_ciudad,correo,extension,imagen_perfil,us.estado ";
    	String tabla="user_usuarios us ";
    	String join="LEFT JOIN user_roles rol ON rol.id_rol = us.rol_usuario ";
    	join +="LEFT JOIN user_areas areas ON areas.id_area = us.area ";
    	join +="LEFT JOIN gen_ciudades ciu ON ciu.id_ciudad = us.ciudad ";
    	Object[][] array=ConexionDB.Consulta(campos, tabla+join, clausula);    	
    	if(array==null)
    	{  		
    		return null;
    	}	
    	Usuario[] objeto = new Usuario[array.length];   	
    	for(int i=0;i<array.length;i++)
    	{
    		int id=(int) array[i][0];
    		String usuario=(String) array[i][1];
    		int rol=(int) array[i][2];
    		String nombreRol=(String) array[i][3];
    		String contrasenia=(String) array[i][4]; 		
    		String nombre1=(String) array[i][5];
    		String nombre2=(String) array[i][6];
    		String apellido1=(String) array[i][7];
    		String apellido2=(String) array[i][8];
    		String cargo=(String) array[i][9];
    		int area=(int) array[i][10];
    		String nombre_area=(String) array[i][11];
    		int ciudad=(int) array[i][12];
    		String nombre_ciudad=(String) array[i][13];
    		String correo=(String) array[i][14];
    		String extension=(String) array[i][15];
    		String foto=(String) array[i][16];
    		int estado=(int) array[i][17];
    		objeto[i]= new Usuario(id,usuario,rol,nombreRol,contrasenia,nombre1,nombre2,apellido1,apellido2,cargo,area,nombre_area,ciudad,nombre_ciudad,correo,extension,foto,estado);   		
    	}		
    	return objeto;	        
    } 
}