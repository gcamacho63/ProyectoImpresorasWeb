/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
/**
 *
 * @author Alejandro
 * 
 * 
 */
public class ConexionDB 
{
    private static String usuario;
    private static int rol;	

    public static String getUsuario() {
        return usuario;
    }
    public static int getRol() {
        return rol;
    }
    
    //Elementos conexion
    public static String driver="com.mysql.jdbc.Driver";
    public static String user="root";
    //Servidor Real
    /*public static String password="LLNyia97162";
    public static String  url="jdbc:mysql://mariadb17660-env-3702462.j.facilcloud.com/dbproyecto";*/
    public static String password="";
    public static String  url="jdbc:mysql://localhost:3306/dbproyecto";
    public static Connection conexion=null;
    public static Statement sentencia;
    public static ResultSet resultado;
    public static int numFilas;

    //-------------------------------CONEXION-------------------------------
    public static boolean conectarDB()
    {		
        boolean valida=false;
        try
        {
            Class.forName(driver);
            conexion= DriverManager.getConnection(url,user,password);
            sentencia = conexion.createStatement();
            valida=true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            conexion=null;
            valida=false;
        }
        return valida;
    }
    
    //-------------------------------SQL BASICOS-------------------------------
    //Consulta Que devuelveun Array de Objetos
    public static Object[][] Consulta(String campos,String tabla,String clausula)
    {
    	conectarDB();
    	String queryCount="SELECT count(*) as numRows FROM "+tabla+" WHERE "+clausula;
        //System.out.println(queryCount);
        String query="SELECT "+campos+" FROM "+tabla+" WHERE "+clausula;
        Object[][] obj=null;
        try
        {
            resultado=sentencia.executeQuery(queryCount);
            resultado.next();
            int numRows=resultado.getInt("numRows");
            if(numRows==0)
            {          	
            	return null;
            }
            resultado.close();
            resultado=sentencia.executeQuery(query);
            resultado.next();
            ResultSetMetaData metaData=resultado.getMetaData();
            int numColum = metaData.getColumnCount();
            obj=new Object[numRows][numColum];
            resultado=sentencia.executeQuery(query);
            //Imprimir Consulta
            //System.out.println(query);
            //Imprimir Consultas
            int j=0;
            while (resultado.next())
            {
                for(int i=0;i<numColum;i++)
                {	
                    obj[j][i]=resultado.getObject(i+1);
                }
                j++;
            }
            conexion.close();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return obj;
    }				
    
    //Metodo de actualizar datos en tabla
    public static boolean Update(String tabla,String cadena,String clausula)
    {
    	conectarDB();
    	int valida=0;
        boolean retorna=false;
        try
        {
            String query="UPDATE "+tabla+" SET "+cadena+" WHERE "+clausula+";";
            //System.out.println(query);
            valida=sentencia.executeUpdate(query);
            if(valida==1)
            {
            	retorna=true;
            }
            conexion.close();
        }
        catch(SQLException e)
        {
                e.printStackTrace();
        }
        return retorna;
    }  
    
    //Metodo para insertar datos
    public static boolean Insert(String tabla,String campos,String cadena)
    {  	
    	conectarDB();
    	int valida=0;
        boolean retorna=false;
        try
        {
            String query="INSERT INTO "+tabla+" ("+campos+") VALUES ("+cadena+");";
            //System.out.println(query);
            valida=sentencia.executeUpdate(query);
            if(valida==1)
            {
            	retorna=true;
            }  
            conexion.close();
        }
        catch(SQLException e)
        {
                e.printStackTrace();
        }
        return retorna;
    }
    
    //Metodo para borrar datos
    public static boolean Delete(String tabla,String clausula)
    {
    	conectarDB();
    	int valida=0;
        boolean retorna=false;
        try
        {
            String query="DELETE FROM "+tabla+" WHERE "+clausula+";";
            //System.out.println(query);
            valida=sentencia.executeUpdate(query);
            if(valida==1)
            {
            	retorna=true;
            }
            conexion.close();
        }
        catch(SQLException e)
        {
                e.printStackTrace();
        }
        return retorna;
    }  
    
    //-------------------------------INICIO DEL SISTEMA-------------------------------
    //Login
    public static Usuario Ingreso(String usuario,String password)
    {
    	conectarDB();
    	String campos="id_usuario,usuario,rol_usuario,nombre_rol,nombre1,nombre2,apellido1,apellido2,cargo,area,nombre_area,ciudad," +
        "nombre_ciudad,correo,extension,imagen_perfil";
        String join="user_usuarios LEFT JOIN user_roles ON id_rol=rol_usuario LEFT JOIN user_areas ON area=id_area " +
        "LEFT JOIN gen_ciudades ON ciudad=id_ciudad";
        String query="SELECT "+campos+" FROM "+join+" WHERE usuario='"+usuario+"' and contrasenia=MD5('"+password+"');";
    	
    	Usuario user;     
        int id;
        String nameRol;
        String nombre1;
        String nombre2;
        String apell1;
        String apell2;
        String cargo;
        int area;
        String nameArea;
        int ciudad;
        String nameCiu;
        String correo;
        String ext;
        String foto;
        try
        {		                             
            resultado=sentencia.executeQuery(query);
            while(resultado.next())
            {			
                id=resultado.getInt("id_usuario");
                usuario=resultado.getString("usuario");
                rol=resultado.getInt("rol_usuario");
                nameRol=resultado.getString("nombre_rol");
                nombre1=resultado.getString("nombre1");
                nombre2=resultado.getString("nombre2");
                apell1=resultado.getString("apellido1");
                apell2=resultado.getString("apellido2");
                cargo=resultado.getString("cargo");
                area=resultado.getInt("area");
                nameArea=resultado.getString("nombre_area");
                ciudad=resultado.getInt("ciudad");
                nameCiu=resultado.getString("nombre_ciudad");
                correo=resultado.getString("correo");
                ext=resultado.getString("extension");
                foto=resultado.getString("imagen_perfil");
                
                user=new Usuario(id,usuario,rol,nameRol,null,nombre1,nombre2,apell1,apell2,cargo,area,nameArea,ciudad,nameCiu,correo,ext,foto);
                return user;
            }
            conexion.close();
        }
        catch(SQLException e)
        {
                e.printStackTrace();
        }
        return null;
    }
    
    //Menu    
    public static Modulo[] MenuModulos(int idRol)
    {
    	conectarDB();
    	Modulo[] modulos = null;
        try
        {		                             
            String campos=" COUNT(nombre) AS num";           
            String join="gen_modulos_permisos mp LEFT JOIN gen_modulos m ON mp.id_modulo = m.id_modulo LEFT JOIN gen_modulos_grupos mg ON mg.id_grupo = m.grupo ";
            String clausula="id_rol= '"+idRol+"' AND m.estado='0' ORDER BY mg.nombre_grupo,m.nombre";
            String query="SELECT "+campos+" FROM "+join+" WHERE "+clausula+";";
            resultado=sentencia.executeQuery(query);
            resultado.next();			
            int numFils =resultado.getInt("num");
            if(numFils<1)
            {
            	return null;
            }
            campos=" m.id_modulo,m.nombre,carpeta,archivo,mg.id_grupo,nombre_grupo,m.descripcion,mg.descripcion,m.controlador ";
            query="SELECT "+campos+" FROM "+join+" WHERE "+clausula+";";
            modulos = new Modulo[numFils];
            resultado=sentencia.executeQuery(query);
            int i=0;
            //System.out.println(query);
            while(resultado.next())
            {			               
                int id=resultado.getInt("id_modulo");
                String nombre=resultado.getString("nombre");
                String descripcion=resultado.getString("descripcion");
                String nombreGrupo=resultado.getString("nombre_grupo");
                String archivo=resultado.getString("archivo");
                String carpeta=resultado.getString("carpeta");
                String controlador=resultado.getString("controlador");
                int idGrupo=resultado.getInt("id_grupo");
                modulos[i]=new Modulo(id,nombre,descripcion,"",archivo,carpeta,controlador,idGrupo,nombreGrupo);             
                i++;
            }
            conexion.close();
        }
        catch(SQLException e)
        {
                e.printStackTrace();
        }
		return modulos;
    }

    public static ModulosGrupos[] MenuGrupos(Modulo[] modulos)
    {   	
    	conectarDB();
    	int posiciones=1;
    	for(int i=1;i<modulos.length;i++)
		{			
			if(modulos[i].getGrupo()!=modulos[i-1].getGrupo())
			{
				posiciones++;
			}
		}
    	ModulosGrupos[] grupos = new ModulosGrupos[posiciones];
		grupos[0]= new ModulosGrupos(modulos[0].getGrupo(),modulos[0].getNombre_grupo(),null);
    	int contGrup=1;
		for(int i=1;i<modulos.length;i++)
		{			
			if(modulos[i].getGrupo()!=grupos[contGrup-1].getId_grupo())
			{
				grupos[contGrup]= new ModulosGrupos(modulos[i].getGrupo(),modulos[i].getNombre_grupo(),null);
				contGrup++;
			}
		}
    	return grupos;   	
    }
}
