--DROP DATABASE db_Lancetilla
USE master 
GO
CREATE DATABASE db_Lancetilla
GO
USE db_Lancetilla
GO
CREATE SCHEMA acce
GO
CREATE SCHEMA mant
GO
CREATE SCHEMA zool
GO
CREATE SCHEMA bota
GO
CREATE SCHEMA fact
GO
--************************************************************************************************************************************************************--

--**************************************************************MÓDULO DE ACCESO******************************************************************************--

--*************************************************************TABLA DE USUARIOS******************************************************************************--
CREATE TABLE acce.tbUsuarios(
usua_Id					INT IDENTITY(1,1)	NOT NULL	PRIMARY KEY,
usua_NombreUsuario		NVARCHAR(100)		NOT NULL,
empl_Id					INT					NOT NULL,
usua_Clave			NVARCHAR(MAX)		NOT NULL,
role_Id					INT					NOT NULL,
usua_Admin				BIT					NOT NULL,

/**********Campos de auditoria***********/
usua_UserCreacion		INT,
usua_FechaCreacion		DATETIME			DEFAULT GETDATE(),
usua_UserModificacion	INT,
usua_FechaModificacion	DATETIME,
usua_Estado				BIT					DEFAULT 1,

CONSTRAINT UK_acce_tbUsuarios_usua_NombreUsuario		UNIQUE(usua_NombreUsuario));
--************************************************************/TABLA DE USUARIOS******************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE ROLES********************************************************************************--
CREATE TABLE acce.tbRoles(
role_Id					INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
role_Descripcion		NVARCHAR(100)			NOT NULL,

/**********Campos de auditoria***********/
role_UserCreacion		INT,
role_FechaCreacion		DATETIME				DEFAULT GETDATE(),
role_UserModificacion	INT,
role_FechaModificacion	DATETIME,
role_Estado				BIT						DEFAULT 1,

CONSTRAINT FK_acce_tbRoles_role_UserCreacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (role_UserCreacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_acce_tbRoles_role_UserModificacion_acce_tbUsuarios_usua_Id	FOREIGN KEY (role_UserModificacion) REFERENCES acce.tbUsuarios(usua_Id));

--*************************************************************/TABLA DE ROLES********************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--************************************************************TABLA DE PANTALLAS******************************************************************************--
CREATE TABLE acce.tbPantallas(
pant_Id						INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
pant_Descripcion			NVARCHAR(100)			NOT NULL,

/**********Campos de auditoria***********/
pant_UserCreacion			INT,
pant_FechaCreacion			DATETIME				DEFAULT GETDATE(),
pant_UserModificacion		INT,
pant_FechaModificacion		DATETIME,

CONSTRAINT FK_acce_tbPantallas_pant_UserCreacion_acce_tbUsuarios_usua_Id	 FOREIGN KEY (pant_UserCreacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_acce_tbPantallas_pant_UserModificacion_acce_tbUsuarios_usua_Id FOREIGN KEY (pant_UserModificacion)	REFERENCES acce.tbUsuarios(usua_Id));


--***********************************************************/TABLA DE PANTALLAS******************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*******************************************************TABLA DE ROLES POR PANTALLA**************************************************************************--
CREATE TABLE acce.tbRolesPantallas(
ropa_Id						INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
role_Id						INT					NOT NULL,
pant_Id						INT					NOT NULL,

/**********Campos de auditoria***********/
ropa_UserCreacion			INT,
ropa_FechaCreacion			DATETIME			DEFAULT GETDATE(),
ropa_UserModificacion		INT,
ropa_FechaModificacion		DATETIME,

CONSTRAINT FK_acce_tbRolesPantallas_ropa_UserCreacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (ropa_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_acce_tbRolesPantallas_ropa_UserModificacion_acce_tbUsuarios_usua_Id	FOREIGN KEY (ropa_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));


--******************************************************/TABLA DE ROLES POR PANTALLA**************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************/MÓDULO DE ACCESO******************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------



--***************************************************************MÓDULO DE ZOOLOGICO**************************************************************************--

--*****************************************************************TABLA DE REINOS****************************************************************************--
CREATE TABLE zool.tbReinos(
rein_Id						INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
rein_Descripcion			NVARCHAR(100)			NOT NULL,

/**********Campos de auditoria***********/
rein_UserCreacion			INT,
rein_FechaCreacion			DATETIME				DEFAULT GETDATE(),
rein_UserModificacion		INT,
rein_FechaModificacion		DATETIME,
rein_Estado					BIT						DEFAULT 1,

CONSTRAINT FK_zool_tbReinos_rein_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (rein_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_zool_tbReinos_rein_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (rein_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));
--*********************************************************/TABLA DE ÁREA DEL ZOOLOGICOS**********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**********************************************************TABLA DE ÁREA DEL ZOOLOGICOS**********************************************************************--
CREATE TABLE zool.tbAreasZoologico(
arzo_Id						INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
arzo_Descripcion			NVARCHAR(100)			NOT NULL,

/**********Campos de auditoria***********/
arzo_UserCreacion			INT,
arzo_FechaCreacion			DATETIME				DEFAULT GETDATE(),
arzo_UserModificacion		INT,
arzo_FechaModificacion		DATETIME,
arzo_Estado					BIT						DEFAULT 1,

CONSTRAINT FK_zool_tbAreasZoologico_arzo_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (arzo_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_zool_tbAreasZoologico_arzo_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (arzo_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));
--*********************************************************/TABLA DE ÁREA DEL ZOOLOGICOS**********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE HABITAT************************************************************************--
CREATE TABLE zool.tbHabitat(
habi_Id						INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
habi_Descripcion			NVARCHAR(100)			NOT NULL,

/**********Campos de auditoria***********/
habi_UserCreacion			INT,
habi_FechaCreacion			DATETIME				DEFAULT GETDATE(),
habi_UserModificacion		INT,
habi_FechaModificacion		DATETIME,
habi_Estado					BIT						DEFAULT 1,

CONSTRAINT FK_zool_tbHabitat_habi_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (habi_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_zool_tbHabitat_habi_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (habi_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));
--*************************************************************/TABLA DE HABITAT************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ESPECIES**************************************************************************--
CREATE TABLE zool.tbEspecies(
espe_Id						INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
espe_Descripcion			NVARCHAR(100)			NOT NULL,

/**********Campos de auditoria***********/
espe_UserCreacion			INT,
espe_FechaCreacion			DATETIME				DEFAULT GETDATE(),
espe_UserModificacion		INT,
espe_FechaModificacion		DATETIME,
espe_Estado					BIT						DEFAULT 1,

CONSTRAINT FK_zool_tbEspecies_espe_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (espe_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_zool_tbEspecies_espe_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (espe_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));
--***************************************************************/TABLA DE ESPECIES**************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE ALIMENTACIÓN************************************************************************--
CREATE TABLE zool.tbAlimentacion(
alim_Id						INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
alim_Descripcion			NVARCHAR(100)			NOT NULL,

/**********Campos de auditoria***********/
alim_UserCreacion			INT,
alim_FechaCreacion			DATETIME				DEFAULT GETDATE(),
alim_UserModificacion		INT,
alim_FechaModificacion		DATETIME,
alim_Estado					BIT						DEFAULT 1,

CONSTRAINT FK_zool_tbAlimentacion_alim_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (alim_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_zool_tbAlimentacion_alim_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (alim_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));
--*************************************************************/TABLA DE ALIMENTACIÓN************************************************************************--

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE RAZAS*****************************************************************************--
CREATE TABLE zool.tbRazas(
raza_Id						INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
raza_Descripcion			NVARCHAR(100)			NOT NULL,
raza_NombreCientifico		NVARCHAR(100)			NOT NULL UNIQUE,
rein_Id						INT						NOT NULL,
habi_Id						INT						NOT NULL,
espe_Id						INT						NOT NULL,

/**********Campos de auditoria***********/
raza_UserCreacion			INT,
raza_FechaCreacion			DATETIME				DEFAULT GETDATE(),
raza_UserModificacion		INT,
raza_FechaModificacion		DATETIME,
raza_Estado					BIT						DEFAULT 1,

CONSTRAINT FK_zool_tbRazas_rein_Id_zool_tbReinos_rein_Id						FOREIGN KEY (rein_Id)					REFERENCES zool.tbReinos(rein_Id),
CONSTRAINT FK_zool_tbRazas_habi_Id_zool_tbHabitat_habi_Id						FOREIGN KEY (habi_Id)					REFERENCES zool.tbHabitat(habi_Id),
CONSTRAINT FK_zool_tbRazas_espe_Id_zool_tbEspecies_espe_Id						FOREIGN KEY (espe_Id)					REFERENCES zool.tbEspecies(espe_Id),
CONSTRAINT FK_zool_tbRazas_raza_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (raza_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_zool_tbRazas_raza_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (raza_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));
--****************************************************************/TABLA DE RAZAS*****************************************************************************--

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ANIMALES**************************************************************************--
CREATE TABLE zool.tbAnimales(
anim_Id							INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
anim_Codigo						NVARCHAR(100)		NOT NULL UNIQUE,
anim_Nombre						NVARCHAR(200)		NOT NULL,
raza_Id							INT					NOT NULL,
arzo_Id							INT					NOT NULL,
alim_Id							INT					NOT NULL,

/**********Campos de auditoria***********/
anim_UserCreacion				INT,
anim_FechaCreacion				DATETIME			DEFAULT GETDATE(),
anim_UserModificacion			INT,
anim_FechaModificacion			DATETIME,
anim_Estado						BIT					DEFAULT 1,

CONSTRAINT FK_zool_tbAnimales_anim_UserCreacion_acce_tbUsuarios_usua_Id				FOREIGN KEY (anim_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_zool_tbAnimales_anim_UserModificacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (anim_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_zool_tbAnimales_arzo_Id_zool_tbAreasZoologico_arzo_Id					FOREIGN KEY (arzo_Id)					REFERENCES zool.tbAreasZoologico(arzo_Id),
CONSTRAINT FK_zool_tbAnimales_raza_Id_zool_tbRazas_raza_Id							FOREIGN KEY (raza_Id)					REFERENCES zool.tbRazas(raza_Id),
CONSTRAINT FK_zool_tbAnimales_alim_Id_zool_tbAlimetacion_alim_Id					FOREIGN KEY (alim_Id)					REFERENCES zool.tbAlimentacion(alim_Id));
--***************************************************************/TABLA DE ANIMALES*************************************************************************--

--**************************************************************/MÓDULO DE ZOOLOGICO**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***********************************************************MÓDULO DE MANTENIMIENTO**************************************************************************--

--***********************************************************TABLA DE DEPARTAMENTOS***************************************************************************--

CREATE TABLE mant.tbDepartamentos(
dept_Id					CHAR(2)             		NOT NULL PRIMARY KEY,
dept_Descripcion		NVARCHAR(100)			NOT NULL,

/**********Campos de auditoria***********/
dept_UserCreacion		INT,
dept_FechaCreacion		DATETIME				DEFAULT GETDATE(),
dept_UserModificacion	INT,
dept_FechaModificacion	DATETIME,
dept_Estado				BIT						DEFAULT 1,

CONSTRAINT FK_mant_tbDepartamento_dept_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (dept_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_mant_tbDepartamento_dept_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (dept_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));

--**********************************************************/TABLA DE DEPARTAMENTOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MUNICIPIOS****************************************************************************--
CREATE TABLE mant.tbMunicipios(
muni_Id							CHAR(4) NOT NULL PRIMARY KEY,
muni_Descripcion				NVARCHAR(100)		NOT NULL,
dept_Id CHAR(2) NOT NULL,

/**********Campos de auditoria***********/
muni_UserCreacion				INT,
muni_FechaCreacion				DATETIME			DEFAULT GETDATE(),
muni_UserModificacion			INT,
muni_FechaModificacion			DATETIME,
muni_Estado						BIT					DEFAULT 1,

CONSTRAINT FK_mant_tbMunicipios_muni_UserCreacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (muni_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_tbMunicipios_dept_Id_mant_tbDepartamentos_dept_Id					FOREIGN KEY (dept_Id)									REFERENCES mant.tbDepartamentos(dept_Id),
CONSTRAINT FK_mant_tbMunicipios_muni_UserModificacion_acce_tbUsuarios_usua_Id	FOREIGN KEY (muni_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));



--*************************************************************/TABLA DE MUNICIPIOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE ESTADOS CIVILES*************************************************************************--
CREATE TABLE mant.tbEstadosCiviles(
estc_Id						INT IDENTITY(1,1)	PRIMARY KEY,
estc_Descripcion			NVARCHAR(100)		NOT NULL,

/**********Campos de auditoria***********/
estc_UserCreacion			INT,
estc_FechaCreacion			DATETIME			DEFAULT GETDATE(),
estc_UserModificacion		INT,
estc_FechaModificacion		DATETIME,
estc_Estado					BIT					DEFAULT 1,

CONSTRAINT FK_mant_tbEstadosCiviles_estc_UserCreacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (estc_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_mant_tbEstadosCiviles_estc_UserModificacion_acce_tbUsuarios_usua_Id	FOREIGN KEY (estc_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));
--**********************************************************/TABLA DE ESTADOS CIVILES*************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE CARGOS*****************************************************************************--
CREATE TABLE mant.tbCargos(
carg_Id						INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
carg_Descripcion			NVARCHAR(100)		NOT NULL,

/**********Campos de auditoria***********/
carg_UserCreacion			INT,
carg_FechaCreacion			DATETIME			DEFAULT GETDATE(),
carg_UserModificacion		INT,
carg_FechaModificacion		DATETIME,
carg_Estado					BIT					DEFAULT 1,

CONSTRAINT FK_mant_tbCargos_carg_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (carg_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_mant_tbCargos_carg_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (carg_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));
--***************************************************************/TABLA DE CARGOS*****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE EMPLEADOS****************************************************************************--
CREATE TABLE mant.tbEmpleados(
empl_Id					INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
empl_Nombre				NVARCHAR(100)		NOT NULL,
empl_Apellido			NVARCHAR(100)		NOT NULL,
empl_Identidad			NVARCHAR(100)		NOT NULL,
empl_FechaNacimiento	DATE				NOT NULL,
empl_Direccion			NVARCHAR(200)		NOT NULL,
empl_Sexo				CHAR(1)				NOT NULL,
empl_Telefono			NVARCHAR(100)		NOT NULL,
estc_Id					INT					NOT NULL,
carg_Id					INT					NOT NULL,
muni_Id					CHAR(4)		     	NOT NULL,

/**********Campos de auditoria***********/
empl_UserCreacion		INT,
empl_FechaCreacion							DATETIME DEFAULT GETDATE(),
empl_UserModificacion	INT,
empl_FechaModificacion	DATETIME,
empl_Estado				BIT					DEFAULT 1,

CONSTRAINT FK_mant_tbEmpleados_estc_Id_mant_tbEstadosCiviles_estc_Id			FOREIGN KEY (estc_Id)				REFERENCES mant.tbEstadosCiviles(estc_Id),
CONSTRAINT FK_mant_tbEmpleados_carg_Id_mant_tbCargos_carg_Id					FOREIGN KEY (carg_Id)				REFERENCES mant.tbCargos(carg_Id),
CONSTRAINT FK_mant_tbEmpleados_muni_Id_mant_tbMunicipios_muni_Id				FOREIGN KEY (muni_Id)				REFERENCES mant.tbMunicipios(muni_Id),
CONSTRAINT FK_mant_tbEmpleados_empl_UserCreacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (empl_UserCreacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_mant_tbEmpleados_empl_UserModificacion_acce_tbUsuarios_usua_Id	FOREIGN KEY (empl_UserModificacion) REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT UK_mant_tbEmpleados_empl_Identidad									UNIQUE(empl_Identidad),
CONSTRAINT CK_mant_tbEmpleados_empl_Sexo										CHECK(empl_Sexo IN ('F', 'M', 'O')));
--*************************************************************/TABLA DE EMPLEADOS****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE VISITANTES****************************************************************************--
CREATE TABLE mant.tbVisitantes(
visi_Id						INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
visi_Nombres				NVARCHAR(100)			NOT NULL,
visi_Apellido				NVARCHAR(100)			NOT NULL,
visi_RTN					NVARCHAR(100)			NOT NULL,
visi_Sexo					CHAR(1)					NOT NULL,

/**********Campos de auditoria***********/
visi_UserCreacion			INT,
visi_FechaCreacion			DATETIME				DEFAULT GETDATE(),
visi_UserModificacion		INT,
visi_FechaModificacion		DATETIME,
visi_Estado					BIT						DEFAULT 1,

CONSTRAINT FK_mant_tbVisitantes_visi_UserCreacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (visi_UserCreacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_mant_tbVisitantes_visi_UserModificacion_acce_tbUsuarios_usua_Id	FOREIGN KEY (visi_UserModificacion) REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT CK_mant_tbVisitantes_visi_Sexo										CHECK(visi_Sexo IN ('F', 'M', 'O')),
CONSTRAINT UK_mant_tbVisitantes_visi_RTN									    UNIQUE(visi_RTN));
--************************************************************/TABLA DE VISITANTES****************************************************************************--

--------------------------------------------------------------------------------------------------------------------------------------------------------------

--**********************************************************TABLA DE TIPOS MANTENIMIENTO********************************************************************--
CREATE TABLE mant.tbTiposMantenimientos(
tima_Id					INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
tima_Descripcion		NVARCHAR(100)		NOT NULL,

/**********Campos de auditoria***********/
tima_UserCreacion		INT,
tima_FechaCreacion		DATETIME			DEFAULT GETDATE(),
tima_UserModificacion	INT,
tima_FechaModificacion	DATETIME,
tima_Estado				BIT					DEFAULT 1,

CONSTRAINT FK_zool_tbTiposMantenimientos_mant_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (tima_UserCreacion) REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_zool_tbTiposMantenimientos_mant_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (tima_UserModificacion) REFERENCES acce.tbUsuarios(usua_Id));
--*********************************************************/TABLA DE TIPOS MANTENIMIENTO**********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MANTENIMIENTO*************************************************************************--
CREATE TABLE mant.tbMantenimientos(
mant_Id					INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
mant_Observaciones		NVARCHAR(100)		NOT NULL,
tima_Id					INT					NOT NULL,

/**********Campos de auditoria***********/
mant_UserCreacion		INT,
mant_FechaCreacion		DATETIME			DEFAULT GETDATE(),
mant_UserModificacion	INT,
mant_FechaModificacion	DATETIME,
mant_Estado				BIT					DEFAULT 1,

CONSTRAINT FK_mant_tbMantenimientos_mant_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (mant_UserCreacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_mant_tbMantenimientos_mant_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (mant_UserModificacion) REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_mant_tbMantenimientos_tima_Id_mant_tbTiposMantenientos_tima_iD			FOREIGN KEY (tima_Id)				REFERENCES mant.tbTiposMantenimientos(tima_Id));
--************************************************************/TABLA DE MANTENIMIENTO*************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*******************************************************TABLA DE MANTENIMIENTO POR ANIMAL********************************************************************--
CREATE TABLE mant.tbMantenimientoAnimal(
maan_Id					INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
anim_Id					INT					NOT NULL,
tima_Id					INT					NOT NULL,
maan_Fecha				Varchar(100)				NOT NULL,

/**********Campos de auditoria***********/
maan_UserCreacion		INT,
maan_FechaCreacion		DATETIME			DEFAULT GETDATE(),
maan_UserModificacion	INT,
maan_FechaModificacion	DATETIME,
maan_Estado				BIT					DEFAULT 1,

CONSTRAINT FK_mant_tbMantenimientoAnimal_maan_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (maan_UserCreacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_mant_tbMantenimientoAnimal_maan_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (maan_UserModificacion) REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_mant_tbMantenimientoAnimal_mant_tbTiposMantenimientos_tima_Id					FOREIGN KEY (tima_Id)				REFERENCES mant.tbTiposMantenimientos(tima_Id),
CONSTRAINT FK_mant_tbMantenimientoAnimal_anim_tbAnimales_anim_Id							FOREIGN KEY (anim_Id)				REFERENCES zool.tbAnimales(anim_Id));
--******************************************************/TABLA DE MANTENIMIENTO POR ANIMAL********************************************************************--

--**********************************************************/MÓDULO DE MANTENIMIENTO**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------



--****************************************************************MÓDULO DE BOTÁNICA**************************************************************************--


--*************************************************************TABLA DE AREAS BOTÁNICAS***********************************************************************--
CREATE TABLE bota.tbAreasBotanicas(
arbo_Id					INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
arbo_Descripcion		NVARCHAR(100)			NOT NULL,

/**********Campos de auditoria***********/
arbo_UserCreacion		INT,
arbo_FechaCreacion		DATETIME				DEFAULT GETDATE(),
arbo_UserModificacion	INT,
arbo_FechaModificacion	DATETIME,
arbo_Estado				BIT						DEFAULT 1,

CONSTRAINT FK_bota_tbAreasBotanicas_arbo_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (arbo_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_bota_tbAreasBotanicas_arbo_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (arbo_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));
--************************************************************/TABLA DE AREAS BOTÁNICAS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--************************************************************TABLA DE TIPOS DE PLANTAS************************************************************************--
CREATE TABLE bota.tbTiposPlantas(
tipl_Id						INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
tipl_NombreComun			NVARCHAR(100)			NOT NULL,
tipl_NombreCientifico		NVARCHAR(100)			NOT NULL UNIQUE,
rein_Id						INT						NOT NULL,

/**********Campos de auditoria***********/
tipl_UserCreacion			INT,
tipl_FechaCreacion			DATETIME				DEFAULT GETDATE(),
tipl_UserModificacion		INT,
tipl_FechaModificacion		DATETIME,
tipl_Estado					BIT						DEFAULT 1,

CONSTRAINT FK_bota_tbTiposPlantas_rein_Id_zool_tbReinos_rein_Id						FOREIGN KEY (rein_Id)					REFERENCES zool.tbReinos(rein_Id),
CONSTRAINT FK_bota_tbTiposPlantas_tipl_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (tipl_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_bota_tbTiposPlantas_tipl_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (tipl_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));
--***********************************************************/TABLA DE TIPOS DE PLANTAS************************************************************************--

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE PLANTAS***************************************************************************--
CREATE TABLE bota.tbPlantas (
plan_Id					INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
plan_Codigo				NVARCHAR(100)		NOT NULL UNIQUE,
arbo_Id					INT					NOT NULL,
tipl_Id					INT					NOT NULL,

/**********Campos de auditoria***********/
plan_UserCreacion		INT,
plan_FechaCreacion		DATETIME			DEFAULT GETDATE(),
plan_UserModificacion	INT,
plan_FechaModificacion	DATETIME,
plan_Estado				BIT					DEFAULT 1,

CONSTRAINT FK_bota_tbPlantas_plan_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (plan_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_bota_tbPlantas_plan_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (plan_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_bota_tbPlantas_tipl_Id_bota_tbTiposPlantas_tipl_Id				FOREIGN KEY (tipl_Id)					REFERENCES bota.tbTiposPlantas(tipl_Id),
CONSTRAINT FK_bota_tbPlantas_arbo_Id_bota_tbAreasBotanicas_arbo_Id				FOREIGN KEY (arbo_Id)					REFERENCES bota.tbAreasBotanicas(arbo_Id));

--****************************************************************/TABLA DE PLANTAS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--************************************************************TABLA DE TIPOS DE CUIDADOS**********************************************************************--
CREATE TABLE bota.tbTiposCuidados(
ticu_Id					INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
ticu_Descripcion		NVARCHAR(100)		NOT NULL,

/**********Campos de auditoria***********/
ticu_UserCreacion		INT,
ticu_FechaCreacion		DATETIME			DEFAULT GETDATE(),
ticu_UserModificacion	INT,
ticu_FechaModificacion	DATETIME,
ticu_Estado				BIT					DEFAULT 1,

CONSTRAINT FK_bota_TiposCuidados_ticu_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (ticu_UserCreacion) REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_bota_TiposCuidados_ticu_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (ticu_UserModificacion) REFERENCES acce.tbUsuarios(usua_Id));
--***********************************************************/TABLA DE TIPOS DE CUIDADOS**********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE CUIDADOS***************************************************************************--
CREATE TABLE bota.tbCuidados(
cuid_Id					INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
cuid_Observacion NVARCHAR(100)		NOT NULL,
ticu_Id					INT					NOT NULL,

/**********Campos de auditoria***********/
cuid_UserCreacion		INT,
cuid_FechaCreacion		DATETIME			DEFAULT GETDATE(),
cuid_UserModificacion	INT,
cuid_FechaModificacion	DATETIME,
cuid_Estado				BIT					DEFAULT 1,

CONSTRAINT FK_bota_tbCuidados_bota_TiposCuidados_ticu_Id							FOREIGN KEY (ticu_Id)				REFERENCES bota.tbTiposCuidados(ticu_Id),
CONSTRAINT FK_bota_tbCuidados_cuid_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (cuid_UserCreacion) REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_bota_tbCuidados_cuid_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (cuid_UserModificacion) REFERENCES acce.tbUsuarios(usua_Id));

--***************************************************************/TABLA DE CUIDADOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE CUIDADO POR PLANTA*********************************************************************--
CREATE TABLE bota.tbCuidadoPlanta(
cupl_Id					INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
plan_Id					INT					NOT NULL,
ticu_Id					INT					NOT NULL,
cupl_Fecha				Varchar(100)				NOT NULL,

/**********Campos de auditoria***********/
cupl_UserCreacion		INT,
cupl_FechaCreacion		DATETIME			DEFAULT GETDATE(),
cupl_UserModificacion	INT,
cupl_FechaModificacion	DATETIME,
cupl_Estado				BIT					DEFAULT 1,

CONSTRAINT FK_bota_tbCuidadosPlanta_cupl_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (cupl_UserCreacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_bota_tbCuidadosPlanta_cupl_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (cupl_UserModificacion) REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_bota_tbCuidadosPlanta_bota_TiposCuidados_ticu_Id							FOREIGN KEY (ticu_Id)				REFERENCES bota.tbTiposCuidados(ticu_Id),
CONSTRAINT FK_bota_tbCuidadosPlanta_bota_tbPlantas_plan_Id								FOREIGN KEY (plan_Id)				REFERENCES bota.tbPlantas(plan_Id));
--************************************************************/TABLA DE CUIDADO POR PLANTA*********************************************************************--


--***************************************************************/MÓDULO DE BOTÁNICA**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***************************************************************MÓDULO DE FACTURACIÓN************************************************************************--

--*****************************************************************TABLA DE TICKETS***************************************************************************--
CREATE TABLE fact.tbTickets(
tick_Id						INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
tick_Descripcion			NVARCHAR(200)		NOT NULL,
tick_Precio					DECIMAL(8,2)		NOT NULL,

/**********Campos de auditoria***********/
tick_UserCreacion			INT,
tick_FechaCreacion			DATETIME			DEFAULT GETDATE(),
tick_UserModificacion		INT,
tick_FechaModificacion		DATETIME,
tick_Estado					BIT					DEFAULT 1,

CONSTRAINT FK_fact_tbTickets_tick_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (tick_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_fact_tbTickets_tick_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (tick_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id));
--****************************************************************/TABLA DE TICKETS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MÉTODOS DE PAGO***********************************************************************--
CREATE TABLE fact.tbMetodosPago(
meto_Id						INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
meto_Descripcion			NVARCHAR(100) NOT NULL,

/**********Campos de auditoria***********/
meto_UserCreacion			INT,
meto_FechaCreacion			DATETIME DEFAULT GETDATE(),
meto_UserModificacion		INT,
meto_FechaModificacion		DATETIME,
meto_Estado					BIT DEFAULT 1,

CONSTRAINT FK_fact_tbMetodosPago_meto_UserCreacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (meto_UserCreacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_fact_tbMetodosPago_meto_UserModificacion_acce_tbUsuarios_usua_Id	FOREIGN KEY (meto_UserModificacion) REFERENCES acce.tbUsuarios(usua_Id));

--************************************************************/TABLA DE MÉTODOS DE PAGO***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE FACTURAS***************************************************************************--
CREATE TABLE fact.tbFacturas(
fact_Id							INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
empl_Id							INT					NOT NULL,
visi_Id							INT					NOT NULL,
meto_Id							INT					NOT NULL,
fact_Fecha						DATETIME		    NOT NULL,

/**********Campos de auditoria***********/
fact_UserCreacion				INT,
fact_FechaCreacion				DATETIME			DEFAULT GETDATE(),
fact_UserModificacion			INT,
fact_FechaModificacion			DATETIME,
fact_Estado						BIT					DEFAULT 1,

CONSTRAINT FK_fact_tbFacturas_fact_UserCreacion_acce_tbUsuarios_usua_Id				FOREIGN KEY (fact_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_fact_tbFacturas_fact_UserModificacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (fact_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_fact_tbFacturas_empl_Id_mant_tbEmpleados_empl_Id						FOREIGN KEY (empl_Id)					REFERENCES mant.tbEmpleados(empl_Id),
CONSTRAINT FK_fact_tbFacturas_visi_Id_mant_tbVisitantes_visi_Id						FOREIGN KEY (visi_Id)					REFERENCES mant.tbVisitantes(visi_Id),
CONSTRAINT FK_fact_tbFacturas_meto_Id_fact_tbMetodosPago							FOREIGN KEY (meto_Id)					REFERENCES fact.tbMetodosPago(meto_Id));
--***************************************************************/TABLA DE FACTURAS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE FACTURAS DETALLE************************************************************************--
CREATE TABLE fact.tbFacturasDetalles(
fade_Id					INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
fact_Id					INT					NOT NULL,
tick_Id					INT					NOT NULL,
fade_Cantidad			INT					NOT NULL,
fade_Total				DECIMAL(8,2)		NOT NULL,

/**********Campos de auditoria***********/
fade_UserCreacion		INT,
fade_FechaCreacion		DATETIME			DEFAULT GETDATE(),
fade_UserModificacion	INT,
fade_FechaModificacion	DATETIME,
fade_Estado				BIT					DEFAULT 1

CONSTRAINT FK_fact_tbFacturasDetalles_fade_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (fade_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_fact_tbFacturasDetalles_fade_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (fade_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_fact_tbFacturasDetalles_tick_Id_fact_tbTickets_tick_Id					FOREIGN KEY (tick_Id)					REFERENCES fact.tbTickets(tick_Id),
CONSTRAINT FK_fact_tbFacturasDetalles_fact_Id_fact_tbFacturas_fact_Id					FOREIGN KEY (fact_Id)					REFERENCES fact.tbFacturas(fact_Id));


--**********************************************************/TABLA DE FACTURAS DETALLE************************************************************************--

--**************************************************************/MÓDULO DE FACTURACIÓN************************************************************************--

--************************************************************************************************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--**********************************************************************EXTRAS********************************************************************************--

ALTER TABLE acce.tbUsuarios ADD CONSTRAINT FK_acce_tbUsuarios_usua_UserCreacion			FOREIGN KEY (usua_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id);
ALTER TABLE acce.tbUsuarios ADD CONSTRAINT FK_acce_tbUsuarios_usua_UserModificacion		FOREIGN KEY (usua_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id);

--*********************************************************************/EXTRAS********************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------



--************************************************************************************************************************************************************--

--**************************************************************INSERT DE ACCESO******************************************************************************--

--*************************************************************TABLA DE USUARIOS******************************************************************************--


  DECLARE @Pass AS NVARCHAR(MAX);
	SET @Pass = CONVERT(NVARCHAR(MAX), HASHBYTES('sha2_512', '123'), 2);


INSERT INTO acce.tbUsuarios(usua_NombreUsuario, empl_Id, usua_Clave, role_Id, usua_Admin, usua_UserCreacion)
VALUES 
  ('Admin', 1, @Pass, 1, 1, 1)

  DECLARE @Pass1 AS NVARCHAR(MAX);
	SET @Pass1 = CONVERT(NVARCHAR(MAX), HASHBYTES('sha2_512', '123'), 2);


INSERT INTO acce.tbUsuarios(usua_NombreUsuario, empl_Id, usua_Clave, role_Id, usua_Admin, usua_UserCreacion)
VALUES 
  ('Sagastume', 1, @Pass1, 1, 0, 1)
 

   DECLARE @Pass2 AS NVARCHAR(MAX);
	SET @Pass2 = CONVERT(NVARCHAR(MAX), HASHBYTES('sha2_512', '123'), 2);
  INSERT INTO acce.tbUsuarios(usua_NombreUsuario, empl_Id, usua_Clave, role_Id, usua_Admin, usua_UserCreacion)
VALUES ('Alex', 3, @Pass2, 3, 1, 1);


   DECLARE @Pass3 AS NVARCHAR(MAX);
	SET @Pass3 = CONVERT(NVARCHAR(MAX), HASHBYTES('sha2_512', '123'), 2);
  INSERT INTO acce.tbUsuarios(usua_NombreUsuario, empl_Id, usua_Clave, role_Id, usua_Admin, usua_UserCreacion)
VALUES ('Selvin', 2, @Pass3, 2, 0, 2)




--************************************************************/TABLA DE USUARIOS******************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE ROLES********************************************************************************--
INSERT INTO acce.tbRoles (role_Descripcion, role_UserCreacion)
VALUES 
  ('Digitador', 1),
  ('Empleado', 2);
--*************************************************************/TABLA DE ROLES********************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--************************************************************TABLA DE PANTALLAS******************************************************************************--
-- mant
INSERT INTO acce.tbPantallas (pant_Descripcion, pant_UserCreacion, pant_FechaCreacion, pant_UserModificacion, pant_FechaModificacion)
VALUES ('Empleados', NULL, GETDATE(), NULL, NULL), --1
       ('Visitantes', NULL, GETDATE(), NULL, NULL), --2
       ('TiposMantenimientos', NULL, GETDATE(), NULL, NULL), --3
       ('Mantenimientos', NULL, GETDATE(), NULL, NULL), --4
       ('MantenimientoAnimal', NULL, GETDATE(), NULL, NULL), --5
       ('Departamentos', NULL, GETDATE(), NULL, NULL), --6
       ('Municipios', NULL, GETDATE(), NULL, NULL), --7
       ('EstadosCiviles', NULL, GETDATE(), NULL, NULL), --8
       ('Cargos', NULL, GETDATE(), NULL, NULL); --9

-- bota
INSERT INTO acce.tbPantallas (pant_Descripcion, pant_UserCreacion, pant_FechaCreacion, pant_UserModificacion, pant_FechaModificacion)
VALUES ('AreasBotanicas', NULL, GETDATE(), NULL, NULL), --10
       ('Cuidados', NULL, GETDATE(), NULL, NULL), --11
       ('Plantas', NULL, GETDATE(), NULL, NULL); --12


-- fact
INSERT INTO acce.tbPantallas (pant_Descripcion, pant_UserCreacion, pant_FechaCreacion, pant_UserModificacion, pant_FechaModificacion)
VALUES ('Tickets', NULL, GETDATE(), NULL, NULL), --13
       ('MetodosPago', NULL, GETDATE(), NULL, NULL), --14
       ('Facturas', NULL, GETDATE(), NULL, NULL) --15
      

-- zool
INSERT INTO acce.tbPantallas (pant_Descripcion, pant_UserCreacion, pant_FechaCreacion, pant_UserModificacion, pant_FechaModificacion)
VALUES ('AreasZoologico', NULL, GETDATE(), NULL, NULL), --16
       ('Habitat', NULL, GETDATE(), NULL, NULL), --17
       ('Especies', NULL, GETDATE(), NULL, NULL), --18
       ('Alimentacion', NULL, GETDATE(), NULL, NULL), --19
       ('Animales', NULL, GETDATE(), NULL, NULL); --20

	   -- acce
INSERT INTO acce.tbPantallas (pant_Descripcion, pant_UserCreacion, pant_FechaCreacion, pant_UserModificacion, pant_FechaModificacion)
VALUES ('Usuarios', NULL, GETDATE(), NULL, NULL), --21
       ('Roles', NULL, GETDATE(), NULL, NULL) --22
--***********************************************************/TABLA DE PANTALLAS******************************************************************************--
----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*******************************************************TABLA DE ROLES POR PANTALLA**************************************************************************--
INSERT INTO ACCE.tbRolesPantallas (role_Id, pant_Id, ropa_UserCreacion, ropa_FechaCreacion)
  VALUES(1,2,1,GETDATE()),
        (1,3,1,GETDATE()),
		(1,4,1,GETDATE()),
		(1,5,1,GETDATE()),
		(1,6,1,GETDATE()),
		(1,7,1,GETDATE()),
		(1,8,1,GETDATE()),
		(1,9,1,GETDATE()),
		(1,10,1,GETDATE()),
		(1,11,1,GETDATE()),
		(1,12,1,GETDATE()),
		(1,13,1,GETDATE()),
		(1,14,1,GETDATE()),
		(1,15,1,GETDATE()),
		(1,16,1,GETDATE()),
		(1,17,1,GETDATE()),
		(1,18,1,GETDATE()),
		(1,19,1,GETDATE()),
		(1,20,1,GETDATE()),
		(1,21,1,GETDATE()),
		(1,22,1,GETDATE()),
		
		(2,10,1,GETDATE()),
		(2,11,1,GETDATE()),
		(2,12,1,GETDATE()),
		(2,13,1,GETDATE()),
		(2,14,1,GETDATE()),
		(2,15,1,GETDATE()),
		(2,16,1,GETDATE()),		
		(2,17,1,GETDATE()),
		(2,18,1,GETDATE()),
		(2,19,1,GETDATE())
--******************************************************/TABLA DE ROLES POR PANTALLA**************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************/INSERT DE ACCESO******************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------



--***************************************************************INSERT DE ZOOLOGICO**************************************************************************--

--*****************************************************************TABLA DE REINOS****************************************************************************--
INSERT INTO zool.tbReinos (rein_Descripcion, rein_UserCreacion)
VALUES 
   ('Animal', 1),
   ('Vegetal', 1),
   ('Fungi', 1),
   ('Protoctista ', 1),
   ('Monera', 1);
--*********************************************************/TABLA DE ÁREA DEL ZOOLOGICOS**********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**********************************************************TABLA DE ÁREA DEL ZOOLOGICOS**********************************************************************--
INSERT INTO zool.tbAreasZoologico (arzo_Descripcion, arzo_UserCreacion)
VALUES 
  ('Acuario', 1),
  ('Safari', 1),
  ('Jardín de Aves', 1),
  ('Terrario', 1),
  ('Zona de Primates', 1),
  ('Hábitat de Felinos', 1),
  ('Aviario', 1),
  ('Granja Educativa', 1),
  ('Paseo de Reptiles', 1),
  ('Pabellón de Mariposas', 1);
--*********************************************************/TABLA DE ÁREA DEL ZOOLOGICOS**********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE HABITATS***************************************************************************--
INSERT INTO zool.tbHabitat (habi_Descripcion, habi_UserCreacion)
VALUES 
    -- Aves
    ('Bosques templados', 1),
    
    -- Mamíferos
    ('Bosques', 1),
        
    -- Anfibios
    ('Bosques húmedos', 1),
    
    -- Peces
    ('Océanos', 1),
    
    -- Arácnidos
    ('Praderas', 1),
    
    -- Crustáceos
    ('Estuarios', 1),
    
    -- Moluscos
    ('Lagos', 1),
    
    -- Primates
    ('Montañas', 1),
    
    -- Cetáceos
    ('Mares', 1),
    
    -- Roedores
    ('Zonas Urbanas', 1),
    
    -- Equinos
    ('Cuevas', 1),
    
    -- Caninos
    ('Jardines', 1),
    
    -- Felinos
    ('Selvas tropicales', 1),
    
    -- Reptiles acuáticos
    ('Ríos', 1),
    
    -- Reptiles terrestres
    ('Desiertos', 1);

--***************************************************************/TABLA DE HABITATS**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ESPECIES***************************************************************************--
INSERT INTO zool.tbEspecies (espe_Descripcion, espe_UserCreacion)
VALUES 
  ('Aves', 1),
  ('Mamíferos', 1),
  ('Reptiles', 1),
  ('Anfibios', 2),
  ('Peces', 1),
  ('Insectos', 1),
  ('Arácnidos', 1),
  ('Crustáceos', 1),
  ('Moluscos', 1),
  ('Marsupiales', 1),
  ('Primates', 1),
  ('Cetáceos', 1),
  ('Carnívoros', 1),
  ('Herbívoros', 1),
  ('Roedores', 1),
  ('Equinos', 1),
  ('Caninos', 1),
  ('Felinos', 1),
  ('Reptiles Acuáticos', 1),
  ('Reptiles Terrestres', 1);
--***************************************************************/TABLA DE ESPECIES**************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE ALIMENTACIÓN************************************************************************--
INSERT INTO zool.tbAlimentacion(alim_Descripcion, alim_UserCreacion)
VALUES 
  ('Semillas y frutas', 1),
  ('Carne y pescado', 1),
  ('Insectos y vegetales', 1),
  ('Insectos y pequeños vertebrados', 1),
  ('Alimento en escamas y pellets', 1),
  ('Néctar y polen', 1),
  ('Insectos y pequeños invertebrados', 1),
  ('Alimento en escamas y vegetales', 1),
  ('Fitoplancton y zooplancton', 1),
  ('Frutas y pequeños insectos', 1),
  ('Frutas y hojas', 1),
  ('Peces y calamares', 1),
  ('Carne fresca', 1),
  ('Pasto y vegetales', 1),
  ('Semillas y nueces', 1),
  ('Hierbas y pasto', 1),
  ('Croquetas y carne de res', 1),
  ('Carne fresca y aves', 1),
  ('Peces y crustáceos', 1),
  ('Insectos y pequeños mamíferos', 1);
--*************************************************************/TABLA DE ALIMENTACIÓN************************************************************************--

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE RAZAS*****************************************************************************--
INSERT INTO zool.tbRazas(raza_Descripcion, raza_NombreCientifico, rein_Id, habi_Id, espe_Id, raza_UserCreacion)
VALUES 
	   ('Águila Real', 'Aquila chrysaetos', 1, 2, 1, 1),
	   ('Colbrí', 'Trochilidae', 1, 12, 1, 1),
	   ('Avestruz Negra Africana', 'Struthio camelus', 1, 5, 1, 1),

	   ('Tigre', 'Panthera tigris', 1, 13, 2, 2),
	   ('León', 'Panthera Leo', 1, 5, 2, 2),
	   ('Elefante Africano', 'Loxodonta Africana', 5, 1, 2, 2),

	   ('Tortuga Marina', 'Cheloniidae', 1, 4, 3, 3),
	   ('Cocodrilo', 'Crocodylidae', 1, 1, 4, 3),

	   ('Rana Arborícola', 'Litoria caerulea',1, 12, 4, 1),
	   ('Salamandras Terrestres', 'Salamandridae', 1, 12, 4, 1),
	   ('Sapo Común', 'Bufo bufo', 1, 12, 4, 1),

	   ('Salmón Keta ', 'Oncorhynchus Keta', 1, 4, 5, 1),
	   ('Tiburón Blanco', 'Carcharodon carcharias', 1, 4, 5, 1),
	   ('Pez Payaso', 'Amphiprioninae', 1, 4, 5, 1),

	   ('Mariposa Monarca', 'Danaus plexippus', 1, 12, 6, 1),
	   ('Abeja de Miel', 'Apis mellifera', 1, 12, 6, 1),
	   ('Escarabajo Rinoceronte', 'Dynastinae', 1, 5, 6, 1),

	   ('Tarántula', 'Theraphosidae', 1, 10, 7, 1),
	   ('Escorpión', 'Scorpiones', 1, 10, 7, 1),
	   ('Viuda Negra', 'Latrodectus', 1, 10, 7, 1),

	   ('Cangrejo Rojo', 'Callinectes sapidu', 1, 4, 8, 1),
	   ('Langosta', 'Palinuridae', 1, 4, 8, 1),
	   ('Camaron', 'Pandalidae', 1, 4, 8, 1),

	   ('Caracol de Jardín', 'Helix aspersa', 1, 12, 9, 1),
	   ('Pulpo pigmeo ', 'Octopus joubini', 1, 7, 9, 1),
	   ('Almeja rubia', 'Ruditapes decussatus', 1, 4, 9, 1),
	   
	   ('Canguro Rojo', 'Macropus rufus', 1, 6, 1, 1),
	   ('Koala de Queensland', 'Phascolarctos cinereus', 1, 3, 10, 1),
	   ('Wombat Común', 'Vombatidae', 1, 3, 10, 1),
	   
	   ('Gorila de montaña', 'Gorilla beringei beringei', 1, 1, 11, 1),
	   ('Chimpancé Común', 'Pan troglodytes', 1, 1, 11, 1),
	   ('Orangután Borneo', 'Pongo pygmaeus', 1, 1, 11, 1),

	   ('Ballena Azul', 'Balaenoptera musculus', 1, 4, 12, 1),
	   ('Delfín Nariz de Botella', 'Tursiops truncatus', 1, 4, 12, 1),
	   ('Orca', 'Orcinus orca', 1, 4, 12, 1),
	   
	   ('Oso Polar', 'Ursus maritimus', 1, 4, 13, 1),
	   ('Lobo', 'Canis lupus', 1, 6, 13, 1),
	   
	   ('Jirafa', 'Giraffa camelopardalis', 1, 13, 14, 1),
	   ('Cebra', 'Equus quagga', 1, 13, 14, 1),
	   
	   ('Ratón ciervo', 'Peromyscus maniculatus', 1, 11, 15, 1),
	   ('Ardilla roja americana', 'Tamiasciurus hudsonicus', 1, 15, 15, 1),
	   ('Conejo blanco de Hotot', 'Oryctolagus cuniculus', 1, 15, 15, 1),

	   ('Caballo Andaluz', 'Equus caballus', 1, 10, 16, 1),
	   ('Cebra de Montaña', 'Equus zebra', 1, 2, 16, 1),
	   ('Asno', 'Equus africanus asinus', 1, 2, 16, 1),

	   ('Perro', 'Canis lupas familiaris', 1, 12, 17, 1),
	   ('Coyote', 'Canis latrans', 1, 12, 17, 1),

	   ('Pantera', 'Panthera pardus', 1, 2, 18, 1),
	   ('Guepardo Sudafricano', 'Acinonyx jubatus jubatus', 1, 2, 18, 1),
	   ('Jaguar', 'Panthera onca', 1, 2, 18, 1),

	   ('Tortuga de Galápagos', 'Chelonoidis nigra', 1, 14, 19, 1),
	   ('Caimán', 'Caimaninae', 1, 14, 19, 1),
	   ('Serpiente Marina', 'Hydrophiinae', 1, 14, 19, 1),

	   ('Dragón de Komodo', 'Varanus komodoensis', 1, 6, 20, 1),
	   ('Tortuga del Desierto', 'Gopherus agassizii', 1, 6, 1, 1),
	   ('Camaleón', 'Chamaeleonidae', 1, 12, 20, 1);


--***************************************************************/TABLA DE RAZAS*****************************************************************************--

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ANIMALES**************************************************************************--
INSERT INTO zool.tbAnimales (anim_Codigo, anim_Nombre, raza_Id, arzo_Id, alim_Id, anim_UserCreacion)
VALUES 

  -- Aves
  ('#AVES0001',   'Trixy', 1, 7, 1,  1),
  ('#AVES0002', 'Noibat', 2, 7, 1, 1 ),
  ('#AVES0003','Bombirdier', 3, 7, 1, 1),
							  
  -- Mamíferos
  ('#MAMS0001',   'Charmander', 4, 2, 2, 1),
  ('#MAMS0002',    'Darmanitan', 5, 2, 2, 1),
  ('#MAMS0003',		'Chimchar', 6, 2, 2, 1),

  -- Reptiles
  ('#REPS0001','Squirtle', 7, 1, 3, 1),
  ('#REPS0002','Totodile',		 8, 1, 3,  1),

  -- Anfibios
  ('#ANFI0001','Politoed',  9, 9, 4,  1),
  ('#ANFI0002','Wooper',  10, 4, 4, 1),
  ('#ANFI0003','Quagsire',  11, 9, 4, 1),


  -- Peces
  ('#PECS0001','Goldy',  12, 1, 5, 1),
  ('#PECS0002','Vaporeon',  13, 1, 5, 1),
  ('#PECS0003','Lanturn',  14, 1, 5, 1),

  -- Insectos
  ('#INSE0001','Butterfly',  15, 10, 6, 1),
  ('#INSE0002','Combee',  16, 4, 6,  1),
  ('#INSE0003','Masquerain',  17, 4, 6,  1),

  -- Arácnidos
  ('#ARAC0001','Araidos',  18, 4, 7,  1),
  ('#ARAC0002','Scizor',  19, 4, 7,  1),
  ('#ARAC0003','Viuda Surskit', 20 ,4, 7,  1),


  -- Crustáceos
  ('#CRUS0001','Crustle', 21, 1, 8,  1),
  ('#CRUS0002','Rastreador', 22, 1, 8, 1),
  ('#CRUS0003','Kravice',  23, 1, 8, 1),

  -- Moluscos
  ('#MOLU0001','Omanyte', 24,  1, 9, 1),
  ('#MOLU0002','Grapploct',  25, 1, 9,  1),
  ('#MOLU0003','Shellder', 26, 1, 9, 1),

  -- Marsupiales
  ('#MARS0001','Khangaskhan', 27,  2, 10,  1),
  ('#MARS0002','Komala',  28, 2, 10,  1),
  ('#MARS0003','Woobat',  29, 2, 10,  1),

  -- Primates
  ('#PRIM0001','Gorila',  30, 5, 11,  1),
  ('#PRIM0002','Chimpancé', 31, 5, 11,  1),
  ('#PRIM0003','Orangután',  32, 5, 11,  1),

  -- Cetáceos
  ('#CETS0001','Wairlod', 33,  1, 12,  1),
  ('#CETS0002','Palafin', 34,  1, 12,  1),
  ('#CETS0003','Kyogre', 35, 1, 12,  1),

  -- Carnívoros
  ('#CARN0001','Zarude', 36, 1, 13,  1),
  ('#CARN0002','Lycanroc', 37, 2, 13,  1),

  -- Hervíboros
  ('#HERV0001','Girafarig', 38, 2, 14, 1),
  ('#HERV0002','Zebstrika',  39, 2, 14,  1),

  -- Equinos
  ('#EQUI0001','Spectrier', 40,  4, 16,  1),
  ('#EQUI0002','Glastier',  41, 4, 16,1),
  ('#EQUI0003','Mudbray', 42,  4, 16,1),

    -- Caninos
  ('#CANI0001','Houndoom', 43, 4, 17, 1),
  ('#CANI0002','Ivy', 44, 4, 17, 1),

    -- Felinos
  ('#FELI0001','Arcanine', 45, 6, 18, 1),
  ('#FELI0002','Zeraora', 46, 6, 18,  1),
  ('#FELI0003','Growlithe', 47, 6, 18, 1),

  -- Reptiles acuáticos
  ('#REAC0001','Drednow', 48, 1, 19,  1),
  ('#REAC0002','Sandile',49,  1, 19,  1),
  ('#REAC0003','Enaks', 50, 1, 19,  1),

  -- Reptiles terrestres
  ('#RETE0001','Goodra', 51,  4, 20,  1),
  ('#RETE0002','Chewtle', 52, 4, 20,  1),
  ('#RETE0003','Kecleon', 53, 9, 20,  1);




--***************************************************************/TABLA DE ANIMALES***************************************************************************--

--***************************************************************/INSERT DE ZOOLOGICO**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***********************************************************INSERT DE MANTENIMIENTO**************************************************************************--

--***********************************************************TABLA DE DEPARTAMENTOS***************************************************************************--
INSERT INTO mant.tbDepartamentos(dept_Id, dept_Descripcion, dept_UserCreacion)
VALUES 
  ('01','Atlántida', 1),
  ('02','Colón', 1),
  ('03','Comayagua', 1),
  ('04','Copán', 1),
  ('05','Cortés', 1),
  ('06','Choluteca', 1),
  ('07','El Paraíso', 1),
  ('08','Francisco Morazán', 1),
  ('09','Gracias a Dios', 1),
  ('10','Intibucá', 1),
  ('11','Islas de la Bahía', 1),
  ('12','La Paz', 1),
  ('13','Lempira', 1),
  ('14','Ocotepeque', 1),
  ('15','Olancho', 1),
  ('16','Santa Bárbara', 1),
  ('17','Valle', 1),
  ('18','Yoro', 1);

--**********************************************************/TABLA DE DEPARTAMENTOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MUNICIPIOS****************************************************************************--
INSERT INTO mant.tbMunicipios(muni_Id, dept_Id, muni_Descripcion, muni_UserCreacion)
VALUES   ('0101','01', 'La Ceiba',				   1),
		 ('0102','01', 'Tela',					   1),
	     ('0103','01', 'La Masica',				   1),
		 ('0104','01', 'Arizona',				   1),
		 ('0105','01', 'Jutiapa',				   1),
		 ('0106','01', 'El Porvenir',			   1),
		 ('0107','01', 'Esparta',				   1),
	     ('0108','01', 'San Francisco',			   1),
		 ('0201','02', 'Trujillo',				   1),
		 ('0202','02', 'Balfate',				   1),
		 ('0203','02', 'Iriona',					   1),
		 ('0204','02', 'Limón',					   1),
		 ('0205','02', 'Sabá',					   1),
		 ('0206','02', 'Santa Fé',				   1),
		 ('0207','02', 'Santa Rosa de Aguán',	   1),
		 ('0208','02', 'Sonaguera',				   1),
		 ('0209','02', 'Tocoa',					   1),
		 ('0210','02', 'Bonito Oriental',		   1),
		 ('0301','03', 'Comayagua',				   1),
		 ('0302','03', 'Ajuterique',				   1),
		 ('0303','03', 'El Rosario',				   1),
		 ('0304','03', 'Esquías',				   1),
		 ('0305','03', 'Humuya',					   1),
		 ('0306','03', 'La Libertad',			   1),
		 ('0307','03', 'Lamaní',					   1),
		 ('0308','03', 'La Trinidad',			   1),
		 ('0309','03', 'Lejamaní',				   1),
		 ('0310','03', 'Meambár',				   1),
		 ('0311','03', 'Minas de Oro',			   1),
		 ('0312','03', 'Ojos de Agua',			   1),
		 ('0313','03', 'San Jerónimo',			   1),
		 ('0314','03', 'San José de Comayagua',	   1),
		 ('0315','03', 'San José del Potrero',	   1),
		 ('0316','03', 'San Luis',				   1),
		 ('0317','03', 'San Sebastián',			   1),
		 ('0318','03', 'Siguatepeque',			   1),
		 ('0319','03', 'Villas de San Antonio',	   1),
		 ('0320','03', 'Las Lajas',				   1),
		 ('0321','03', 'Taulabé',				   1),
		 ('0401','04', 'Santa Rosa de Copán',	   1),
		 ('0402','04', 'Cabañas',				   1),
		 ('0403','04', 'Concepción',				   1),
		 ('0404','04', 'Copán Ruinas',			   1),
		 ('0405','04', 'Corquín',				   1),
		 ('0406','04', 'Cucuyagua',				   1),
		 ('0407','04', 'Dolores',				   1),
		 ('0408','04', 'Dulce Nombre',			   1),
		 ('0409','04', 'El Paraíso',				   1),
		 ('0410','04', 'Florida',				   1),
		 ('0411','04', 'Lajigua',				   1),
		 ('0412','04', 'La Unión',				   1),
		 ('0413','04', 'Nueva Arcadia',			   1),
		 ('0414','04', 'San Agustín',			   1),
		 ('0415','04', 'San Antonio',			   1),
		 ('0416','04', 'San Jerónimo',			   1),
		 ('0417','04', 'San José',				   1),
		 ('0418','04', 'San Juan de Ocoa',		   1),
		 ('0419','04', 'San Nicolás',			   1),
		 ('0420','04', 'San Pedro',				   1),
		 ('0421','04', 'Santa Rita',				   1),
		 ('0422','04', 'Trinidad de Copán',		   1),
		 ('0423','04', 'Veracrúz',				   1),
		 ('0501','05', 'San Pedro Sula',			   1),
		 ('0502','05', 'Choloma',				   1),
		 ('0503','05', 'Omoa',					   1),
		 ('0504','05', 'Pimienta',				   1),
		 ('0505','05', 'Potrerillos',			   1),
		 ('0506','05', 'Puerto Cortés',			   1),
		 ('0507','05', 'San Antonio de Cortés',	   1),
	     ('0508','05', 'San Francisco de Yojoa',    1),
		 ('0509','05', 'San Manuel',				   1),
		 ('0510','05', 'Santa Cruz de Yoja',		   1),
		 ('0511','05', 'La Lima',				   1),
		 ('0601','06', 'Pascilagua',				   1),
		 ('0602','06', 'Comcepción de María',	   1),
		 ('0603','06', 'Duyure',					   1),
		 ('0604','06', 'El Corpues',				   1),
		 ('0605','06', 'El Triunfo',				   1),
		 ('0606','06', 'Marcovia',				   1),
		 ('0607','06', 'Morolica',				   1),
		 ('0608','06', 'Namasigue',				   1),
		 ('0609','06', 'Orocuina',				   1),
		 ('0610','06', 'Pespire',				   1),
		 ('0611','06', 'San Antonio de Flores',	   1),
		 ('0612','06', 'San Isidrio',			   1),
		 ('0613','06', 'San José',				   1),
		 ('0614','06', 'San Marcos de Colón',	   1),
		 ('0615','06', 'Santa Ana de Yuscuare',	   1),
		 ('0701','07', 'Yuscarán',				   1),
		 ('0702','07', 'Alauca',					   1),
		 ('0703','07', 'Danlí',					   1),
		 ('0704','07', 'El Paraíso',				   1),
		 ('0705','07', 'Guinope',				   1),
		 ('0706','07', 'Jacaleapa',				   1),
		 ('0707','07', 'Liure',					   1),
		 ('0708','07', 'Morocelí',				   1),
		 ('0709','07', 'Oropolí',				   1),
		 ('0710','07', 'Potrerillos',			   1),
		 ('0711','07', 'San Antonio de Flores',	   1),
		 ('0712','07', 'San Lucas',				   1),		 
		 ('0713','07', 'San Matías',				   1),
		 ('0714','07', 'Soledad',				   1),
		 ('0715','07', 'Teupasenti',				   1),
		 ('0716','07', 'Texiguat',				   1),
		 ('0717','07', 'Vado Ancho',				   1),		
		 ('0718','07', 'Yauyupe',				   1),
		 ('0719','07', 'Trojes',					   1),
		 ('0801','08', 'Distrito Central',		   1),
		 ('0802','08', 'Alubarén',				   1),
		 ('0803','08', 'Cedros',					   1),
		 ('0804','08', 'Cucarén',				   1),
		 ('0805','08', 'El Porvenir',			   1),
		 ('0806','08', 'Guaimaca',				   1),
		 ('0807','08', 'La Libertad',			   1),
		 ('0808','08', 'La Venta',				   1),
		 ('0809','08', 'Lepaterique',			   1),
		 ('0810','08', 'Maraita',				   1),
		 ('0811','08', 'Maralé',					   1),
		 ('0812','08', 'Nueva Armedia',			   1),
		 ('0813','08', 'Ojojona',				   1),
		 ('0814','08', 'Orica',					   1),
		 ('0815','08', 'Reitoca',				   1),
		 ('0816','08', 'Sabana Grande',			   1),
		 ('0817','08', 'San Antonio de Oriente',    1),
		 ('0818','08', 'San Buenaventura',		   1),
		 ('0819','08', 'San Ignacio',			   1),
		 ('0820','08', 'San Juan de Flores',		   1),
		 ('0821','08', 'San Miguelito',			   1),
		 ('0822','08', 'Santa Ana',				   1),
		 ('0823','08', 'Santa Lucía',			   1),
		 ('0824','08', 'Talanga',				   1),
		 ('0825','08', 'Tatumbla',				   1),
		 ('0826','08', 'Valle de Ángeles',		   1),
		 ('0827','08', 'Villas de San Fernando',    1),
		 ('0828','08', 'Vallecillo',				   1),
		 ('0901','09', 'Puerto Lempira',			   1),
		 ('0902','09', 'Brus Laguna',			   1),
		 ('0903','09', 'Hauas',					   1),
		 ('0904','09', 'Juan Francisco Bulnes',	   1),
		 ('0905','09', 'Villeda Morales',		   1),
		 ('0906','09', 'Wanpucirpe',				   1),
		 ('1001','10', 'La Esperanza',			   1),
		 ('1002','10', 'Camasca',				   1),
		 ('1003','10', 'Colomcagua',				   1),
		 ('1004','10', 'Concepción',				   1),
		 ('1005','10', 'Dolores',				   1),
		 ('1006','10', 'Intibuca',				   1),
		 ('1007','10', 'Jesus de Otoro',			   1),
		 ('1008','10', 'Magadalena',				   1),
		 ('1009','10', 'Masaguara',				   1),
		 ('1010','10', 'San Antonio',			   1),
		 ('1011','10', 'San Isidro',				   1),
		 ('1012','10', 'San Juan',				   1),
		 ('1013','10', 'San Marcos de la Sierra',   1),
		 ('1014','10', 'San Miguelito',			   1),
		 ('1015','10', 'Santa Lucía',			   1),
		 ('1016','10', 'Yamaranguila',			   1),
		 ('1017','10', 'San Francisco de Opalaca',  1),
		 ('1101','11', 'Roatán',					   1),
		 ('1102','11', 'Guanaja',				   1),
		 ('1103','11', 'José Santos Guardiola',	   1),
		 ('1104','11', 'Utila',					   1),
		 ('1201','12', 'Aguanqueterique',		   1),
		 ('1202','12', 'Cabañas',				   1),
		 ('1203','12', 'Cane',					   1),
		 ('1204','12', 'Chinacla',				   1),
		 ('1205','12', 'Guagiquiro',				   1),
		 ('1206','12', 'Lauterique',				   1),
		 ('1207','12', 'Marcala',				   1),
		 ('1208','12', 'Mercedes de Oriente',	   1),
		 ('1209','12', 'Opatoro',				   1),
		 ('1210','12', 'San Antonio del Norte',	   1),
		 ('1211','12', 'San José',				   1),
		 ('1212','12', 'San Juan',				   1),
		 ('1213','12', 'San Pedro de Tutule',	   1),
		 ('1214','12', 'Santa Ana',				   1),
		 ('1215','12', 'San Elena',				   1),
		 ('1216','12', 'Santa María',			   1),
		 ('1217','12', 'Santiago de Puringla',	   1),
		 ('1218','12', 'Yarula',					   1),
		 ('1301','13', 'Gracias',				   1),
		 ('1302','13', 'Belén',					   1),
		 ('1303','13', 'Candelaria',				   1),
		 ('1304','13', 'Cololaca',				   1),
		 ('1305','13', 'Erandique',				   1),
		 ('1306','13', 'Guascinse',				   1),
		 ('1307','13', 'Guarita',				   1),
		 ('1308','13', 'La Campa',				   1),
		 ('1309','13', 'La Iguala',				   1),
		 ('1310','13', 'Las Flores',				   1),
		 ('1311','13', 'La Unión',				   1),
		 ('1312','13', 'La Virtud',				   1),
		 ('1313','13', 'Lepaera',				   1),
		 ('1314','13', 'Mapulaca',				   1),
		 ('1315','13', 'Piraera',				   1),
		 ('1316','13', 'San Andrés',				   1),
		 ('1317','13', 'San Francisco',			   1),
		 ('1318','13', 'San Juan Guarita',		   1),
		 ('1319','13', 'San Manuel Colohete',	   1),
		 ('1320','13', 'San Rafael',				   1),
		 ('1321','13', 'San Sebastián',			   1),
		 ('1322','13', 'Santa Crúz',				   1),
		 ('1323','13', 'Talgua',					   1),
		 ('1324','13', 'Tambla',					   1),
		 ('1325','13', 'Tomalá',					   1),
		 ('1326','13', 'Valladolid',				   1),
		 ('1327','13', 'Virginia',				   1),
		 ('1328','13', 'San Marcos de Caiquin',	   1),
		 ('1401','14', 'Ocotepeque',				   1),
		 ('1402','14', 'Belén Gualcho',			   1),
		 ('1403','14', 'Concepción',				   1),
		 ('1404','14', 'Dolores Merendón',		   1),
		 ('1405','14', 'Fraternidad',			   1),
		 ('1406','14', 'La Encarnación',			   1),
		 ('1407','14', 'La Labor',				   1),
		 ('1408','14', 'Lucerna',				   1),
		 ('1409','14', 'Mercedes',				   1),
		 ('1410','14', 'San Fernando',			   1),
		 ('1411','14', 'San Francisco del Valle',   1),
		 ('1412','14', 'San Jorge',				   1),
		 ('1413','14', 'San Marcos',				   1),
		 ('1414','14', 'Santa Fé',				   1),
		 ('1415','14', 'Sesenti',				   1),
		 ('1416','14', 'Sinuapa',				   1),
		 ('1501','15', 'Juticalpa',				   1),
		 ('1502','15', 'Campamento',				   1),
		 ('1503','15', 'Catacamas',				   1),
		 ('1504','15', 'Concordia',				   1),
		 ('1505','15', 'Dulce Nombre de Culmí',	   1),
		 ('1506','15', 'El Rosario',				   1),
		 ('1507','15', 'Esquípulas del Norte',	   1),
		 ('1508','15', 'Gualaco',				   1),
		 ('1509','15', 'Guarizama',				   1),
		 ('1510','15', 'Guata',					   1),
		 ('1511','15', 'Guayape',				   1),
		 ('1512','15', 'Jano',					   1),
		 ('1513','15', 'La Unión',				   1),
		 ('1514','15', 'Mangulile',				   1),
		 ('1515','15', 'Manto',					   1),
		 ('1516','15', 'Salamá',					   1),
		 ('1517','15', 'San Esteban',			   1),
		 ('1518','15', 'San Francisco de Becerra',  1),
		 ('1519','15', 'San Francisco de La Paz',   1),
		 ('1520','15', 'San María del Real',		   1),
		 ('1521','15', 'Silca',					   1),
		 ('1522','15', 'Yocon',					   1),
		 ('1523','15', 'Patuca',					   1),
		 ('1601','16', 'Santa Bárbara',			   1),
		 ('1602','16', 'Arada',					   1),
		 ('1603','16', 'Atima',					   1),
		 ('1604','16', 'Azacualpa',				   1),
		 ('1605','16', 'Ceguaca',				   1),
		 ('1606','16', 'Concepción del Norte',	   1),
		 ('1607','16', 'Concepción del Sur',		   1),
		 ('1608','16', 'Chinda',					   1),
		 ('1609','16', 'El Níspero',				   1),
		 ('1610','16', 'Gualala',				   1),
		 ('1611','16', 'Ilama',					   1),
		 ('1612','16', 'Las Vegas',				   1),
		 ('1613','16', 'Macuelizo',				   1),
		 ('1614','16', 'Naranjito',				   1),
		 ('1615','16', 'Nuevo Celilac',			   1),
		 ('1616','16', 'Nueva Frontera',			   1),
		 ('1617','16', 'Petoa',					   1),
		 ('1618','16', 'Protección',				   1),
		 ('1619','16', 'Quimistán',				   1),
		 ('1620','16', 'San Francisco de Ojuera',   1),
		 ('1621','16', 'San José de Colinas',	   1),
		 ('1622','16', 'San Luis',				   1),
		 ('1623','16', 'San Marcos',				   1),
		 ('1624','16', 'San Nicolás',			   1),
		 ('1625','16', 'San Pedro Zacapa',		   1),
		 ('1626','16', 'San Vicente Centenario',    1),
		 ('1627','16', 'Santa Rita',				   1),
		 ('1628','16', 'Trinidad',				   1),
		 ('1702','17', 'Nacome',					   1),
		 ('1703','17', 'Alianza',				   1),
		 ('1704','17', 'Amapala',				   1),
		 ('1705','17', 'Aramecina',				   1),
		 ('1706','17', 'Caridad',				   1),
		 ('1707','17', 'Goascorán',				   1),
		 ('1701','17', 'Langue',					   1),
		 ('1708','17', 'San Francisco de Coray',    1),
		 ('1709','17', 'San Lorenzo',			   1),
		 ('1801','18', 'Yoro',					   1),
		 ('1802','18', 'Arenal',					   1),
		 ('1803','18', 'El Negrito',				   1),
		 ('1804','18', 'El Progreso',			   1),
		 ('1805','18', 'Jocón',					   1),
		 ('1806','18', 'Morazán',				   1),
		 ('1807','18', 'Olanchito',				   1),
		 ('1808','18', 'Santa Rita',				   1),
		 ('1809','18', 'Sulaco',					   1),
		 ('1810','18', 'Victoria',				   1),
		 ('1811','18', 'Yorito',					   1);
--*************************************************************/TABLA DE MUNICIPIOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE ESTADOS CIVILES*************************************************************************--
INSERT INTO mant.tbEstadosCiviles(estc_Descripcion, estc_UserCreacion)
VALUES 
  ('Soltero', 1),
  ('Casado', 1),
  ('Divorciado', 1),
  ('Viudo', 1),
  ('Unión libre', 1),
  ('Separado', 1);
--**********************************************************/TABLA DE ESTADOS CIVILES*************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE CARGOS*****************************************************************************--
INSERT INTO mant.tbCargos(carg_Descripcion, carg_UserCreacion)
VALUES 
  ('Director del Zoológico', 1),
  ('Curador de Animales', 1),
  ('Veterinario', 1),
  ('Encargado de Alimentación', 1),
  ('Guía de Visitantes', 1);
--***************************************************************/TABLA DE CARGOS*****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE EMPLEADOS****************************************************************************--
INSERT INTO mant.tbEmpleados(empl_Nombre, empl_Apellido, empl_Identidad, empl_FechaNacimiento, empl_Direccion, empl_Sexo, empl_Telefono, estc_Id, carg_Id, muni_Id, empl_UserCreacion)
VALUES
('Juan', 'Pérez', '0801-1980-12345', '1980-01-08', 'Calle Principal 123', 'M', '9999-1234', 1, 1, '0201', 1),
('María', 'Gómez', '0502-1990-67890', '1990-02-05', 'Avenida Central 456', 'F', '8888-5678', 2, 2, '0202', 1),
('Carlos', 'López', '0303-1985-45678', '1985-03-03', 'Colonia Los Pinos 789', 'M', '7777-9876', 1, 3, '0203', 2),
('Laura', 'Hernández', '1004-1995-23456', '1995-04-10', 'Barrio El Bosque 567', 'F', '6666-2345', 3, 1, '0204', 2),
('Pedro', 'Rodríguez', '0705-1982-34567', '1982-05-07', 'Residencial Las Flores 890', 'M', '5555-3456', 2, 2, '0205', 3),
('Ana', 'Torres', '2006-1993-45678', '1993-06-20', 'Colonia San Miguel 123', 'F', '4444-4567', 1, 3, '0206', 3),
('Luis', 'Martínez', '1507-1988-56789', '1988-07-15', 'Barrio La Esperanza 456', 'M', '3333-5678', 2, 1, '0207', 1),
('Sofía', 'García', '1208-1998-67890', '1998-08-12', 'Residencial Los Ángeles 789', 'F', '2222-6789', 3, 2, '0208', 1),
('Jorge', 'Díaz', '0909-1987-78901', '1987-09-09', 'Avenida Central Sur 234', 'M', '1111-7890', 1, 3, '0209', 1),
('Carolina', 'Ramírez', '0410-1997-89012', '1997-10-04', 'Calle Los Alamos 567', 'F', '0000-8901', 2, 1, '0210', 1);
--*************************************************************/TABLA DE EMPLEADOS****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************/TABLA DE VISITANTES***************************************************************************--
INSERT INTO mant.tbVisitantes (visi_Nombres, visi_Apellido, visi_RTN, visi_Sexo, visi_UserCreacion)
VALUES 
  ('Cliente', 'Preferido', '0',  'M', 1),
  ('María', 'González', '0801199012345',  'F', 1),
  ('Carlos', 'López', '0502198567890',    'M', 1),
  ('Laura', 'Hernández', '0303199545678', 'F', 1),
  ('Pedro', 'Rodríguez', '1004198223456', 'M', 1),
  ('Ana', 'Torres', '0705199334567',      'F', 1),
  ('Luis', 'Martínez', '2006198845678',   'M', 1),
  ('Sofía', 'García', '1507199856789',    'F', 1),
  ('Jorge', 'Díaz', '1208198767890',      'M', 1),
  ('Carolina', 'Ramírez', '0909199778901','F', 1),
  ('Ricardo', 'Sánchez', '0410198589012', 'M', 1);
--*************************************************************/TABLA DE VISITANTES***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE TIPOS MANTENIMIENTO**********************************************************************--
INSERT INTO mant.tbTiposMantenimientos (tima_Descripcion, tima_UserCreacion)
VALUES
    ('Limpieza de jaula',1),
    ('Alimentación de animales',1),
    ('Baño',1),
	('Curación de animales',1),
    ('Control de plagas',1),
    ('Entrenamiento',1),
    ('Cambio de temperatura',1);

--**********************************************************/TABLA DE TIPOS MANTENIMIENTO**********************************************************************--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***************************************************************TABLA DE MANTENIMIENTO************************************************************************--
INSERT INTO mant.tbMantenimientos (mant_Observaciones, tima_Id, mant_UserCreacion)
VALUES
    ('Limpieza de excremento de aves',											1,   1),
    ('Se le ha dado 2KG de suplementos a los delfines',							2,  1),
    ('Çuración de herida al area de Felinos',									4,   1),
    ('Baño a las jirajas bebés',												3, 1),
    ('Control de cucarachas',													5,   1),
    ('Curación de la pata derecha de las cebras',								4,  1),
    ('Entrenamiento físico de los lobos',										6,  1),
    ('Curación de infección de los tigres',										4,    1),
    ('Limpieza de piscinas en el área de boas',									1,  1),
    ('Cambio de temperatura en el invernadero de los dragones de comodo',		7, 1);

--**************************************************************/TABLA DE MANTENIMIENTO***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*******************************************************TABLA DE MANTENIMIENTO POR ANIMAL********************************************************************--
INSERT INTO mant.tbMantenimientoAnimal(anim_Id, tima_Id, maan_Fecha,maan_UserCreacion)
VALUES  (21, 1,GETDATE(), 1),
		(2, 2,GETDATE(), 1),
		(3, 3, GETDATE(),1),
		(14, 4, GETDATE(),1),
		(10, 5, GETDATE(),1),
		(29, 6, GETDATE(),1),
		(46, 7, GETDATE(),1),
		(23, 1, GETDATE(),1),
		(7, 2,GETDATE(), 1),
		(50, 3, GETDATE(),1);
--******************************************************/TABLA DE MANTENIMIENTO POR ANIMAL********************************************************************--

--**********************************************************/INSERT DE MANTENIMIENTO**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--****************************************************************INSERT DE BOTÁNICA**************************************************************************--

--*************************************************************TABLA DE AREAS BOTÁNICAS***********************************************************************--
INSERT INTO bota.tbAreasBotanicas (arbo_Descripcion, arbo_UserCreacion)
VALUES
    ('Jardín de Cactus', 1),
    ('Orquideario', 1),
    ('Sendero de Plantas Tropicales', 1),
    ('Bosque de Coníferas', 1),
    ('Rosaleda', 1),
    ('Jardín de Hierbas Aromáticas', 1),
    ('Invernadero de Plantas Tropicales', 1),
    ('Huerto de Frutales', 1),
    ('Laberinto de Arbustos', 1),
    ('Estanque de Plantas Acuáticas', 1);
--************************************************************/TABLA DE AREAS BOTÁNICAS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--************************************************************TABLA DE TIPOS DE PLANTAS***********************************************************************--
INSERT INTO bota.tbTiposPlantas (tipl_NombreComun,tipl_NombreCientifico, rein_Id, tipl_UserCreacion)
VALUES
    ('Cactus de Navidad', 'Schlumbergera truncata', 2, 1),
	('Cactus de Pascua', 'Hatiora gaertneri', 2, 1),

    ('Orquídea Mariposa', 'Phalaenopsis spp.', 2, 1),
	('Orquídea Cattleya', 'Cattleya spp.', 2, 1),

    ('Begonia Rex', 'Begonia rex-cultorum',2, 1),
	('Bananero', 'Musa spp.', 2,  1),

    ('Pino de Monterrey', 'Pinus radiata',2, 1),
	('Cedro del Atlas', 'Cedrus atlantica',2, 1),

    ('Rosa del té', 'Camellia sinensis',2, 1),
	('Rosa de Damasco', 'Rosa damascena',2, 1),

    ('Menta', 'Mentha spp.',2, 1),
	('Albahaca', 'Ocimum basilicum',2, 1),

    ('Planta de Serpiente', 'Sansevieria trifasciata',2, 1),
	('Cala', 'Zantedeschia spp.', 2, 1),

    ('Manzano', 'Malus domestica', 2, 1),
	('Naranjo', 'Citrus sinensis', 2, 1),

    ('Boj', 'Buxus spp.',2, 1),
	('Ligustro', 'Ligustrum spp.',2, 1),

    ('Lirio de Agua', 'Nymphaea spp.',2, 1),
	('Papiro', 'Cyperus papyrus',2, 1);

--***********************************************************/TABLA DE TIPOS DE PLANTAS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE PLANTAS***************************************************************************--
INSERT INTO bota.tbPlantas (plan_Codigo, tipl_Id, arbo_Id, plan_UserCreacion)
VALUES
    -- Jardín de Cactus
    ('#CACT0001', 1,  1, 1),
    ('#CACT0002', 2,  1, 1),

    -- Orquideario
    ('#ORQU0001', 3,  2, 1),
    ('#ORQU0002', 4,  2, 1),

    -- Sendero de Plantas Tropicales
    ('#PLTR0001', 5,  3, 1),
    ('#PLTR0002', 6, 3,  1),

    -- Bosque de Coníferas
    ('#CONI0001', 7,  4, 1),
    ('#CONI0002', 8,  4, 1),

    -- Rosaleda
    ('#ROSA0001', 9,  5, 1),
    ('#ROSA0002', 10,  5, 1),

    -- Jardín de Hierbas Aromáticas
    ('#HIAR0001', 11, 6, 1),
    ('#HIAR0002', 12,  6, 1),

    -- Invernadero de Plantas Tropicales
    ('#INTR0001', 13,  7, 1),
    ('#INTR0002',14,  7, 1),

    -- Huerto de Frutales
    ('#HUFR0001',15,  8, 1),
    ('#HUFR0002',16,  8, 1),

    -- Laberinto de Arbustos
    ('#LAAR0001', 17,  9, 1),
    ('#LAAR0002', 18,  9, 1),

    -- Estanque de Plantas Acuáticas
    ('#PLAC0001', 19,  10, 1),
    ('#PLAC0002', 20,  10, 1);

--****************************************************************/TABLA DE PLANTAS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--************************************************************TABLA DE TIPOS DE CUIDADOS***********************************************************************--

INSERT INTO bota.tbTiposCuidados (ticu_Descripcion, ticu_UserCreacion)
VALUES
    ('Riego adecuado', 1),
    ('Luz adecuada', 1),
    ('Fertilización', 1),
    ('Control de plagas', 1),
    ('Poda', 1),
    ('Transplante', 1),
    ('Control de temperatura y humedad', 1),
    ('Eliminación de hojas secas o marchitas', 1),
    ('Protección contra condiciones climáticas extremas', 1),
    ('Monitoreo y cuidado regular', 1);

--***********************************************************/TABLA DE TIPOS DE CUIDADOS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE CUIDADOS****************************************************************************--
INSERT INTO bota.tbCuidados (cuid_Observacion, ticu_Id, cuid_UserCreacion)
VALUES
    ('Regar las plantas adecuadamente según sus necesidades.', 1, 1),
    ('Proporcionar la cantidad adecuada de luz a cada planta.', 2, 1),
    ('Aplicar fertilizante de acuerdo con las indicaciones para promover un crecimiento saludable.', 3, 1),
    ('Realizar un control regular de plagas y tomar medidas adecuadas para su eliminación.', 4, 1),
    ('Realizar podas regulares para mantener la forma y salud de las plantas.', 5, 1),
    ('Realizar transplantes cuando las plantas necesiten más espacio para crecer.', 6, 1),
    ('Controlar la temperatura y humedad del entorno para adaptarse a las necesidades de las plantas.', 7, 1),
    ('Eliminar las hojas secas o marchitas para mantener un aspecto saludable.', 8, 1),
    ('Proteger las plantas de condiciones climáticas extremas como heladas o altas temperaturas.', 9, 1),
    ('Realizar un monitoreo regular y brindar cuidado constante a las plantas.', 10, 1);

--***************************************************************/TABLA DE CUIDADOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**********************************************************TABLA DE CUIDADOS POR PLANTA***********************************************************************--
INSERT INTO bota.tbCuidadoPlanta (plan_Id, ticu_Id, cupl_Fecha, cupl_UserCreacion)
VALUES
    (1, 1, '2023-05-29', 1),
    (2, 2, '2023-05-29', 1),
    (1, 3, '2023-05-29', 1),
    (3, 4, '2023-05-29', 1),
    (2, 5, '2023-05-29', 1),
    (4, 6, '2023-05-29', 1),
    (3, 7, '2023-05-29', 1),
    (1, 8, '2023-05-29', 1),
    (4, 9, '2023-05-29', 1),
    (2, 10, '2023-05-29', 1);

--*********************************************************/TABLA DE CUIDADOS POR PLANTA***********************************************************************--

--***************************************************************/MÓDULO DE BOTÁNICA**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***************************************************************INSERT DE FACTURACIÓN************************************************************************--

--*****************************************************************TABLA DE TICKETS***************************************************************************--
INSERT INTO fact.tbTickets (tick_Descripcion, tick_Precio, tick_UserCreacion)
VALUES ('Ticket de entrada al zoológico', 20.00, 1),
	   ('Ticket de entrada al jardín botánico', 15.00, 1);

--****************************************************************/TABLA DE TICKETS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MÉTODOS DE PAGO***********************************************************************--
INSERT INTO fact.tbMetodosPago (meto_Descripcion, meto_UserCreacion)
VALUES
    ('Efectivo', 1),
    ('Tarjeta de crédito', 1),
    ('Tarjeta de débito', 1),
    ('Transferencia bancaria', 1),
    ('PayPal', 1),
    ('Cheque', 1),
    ('Vale de regalo', 1),
    ('Criptomoneda', 1),
    ('Pago móvil', 1),
    ('Puntos de fidelidad', 1);
--************************************************************/TABLA DE MÉTODOS DE PAGO***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE FACTURAS***************************************************************************--
INSERT INTO fact.tbFacturas (empl_Id, visi_Id, meto_Id, fact_Fecha, fact_UserCreacion, fact_FechaCreacion)
VALUES (1, 1, 1, GETDATE(), 1, GETDATE());

INSERT INTO fact.tbFacturas (empl_Id, visi_Id, meto_Id, fact_Fecha, fact_UserCreacion, fact_FechaCreacion)
VALUES (2, 2, 2, GETDATE(), 2, GETDATE());




--***************************************************************/TABLA DE FACTURAS***************************************************************************--



--***********************************************************TABLA DE FACTURAS DETALLE************************************************************************--
-- Insertar en la tabla tbFacturasDetalles
INSERT INTO fact.tbFacturasDetalles (fact_Id, tick_Id, fade_Cantidad, fade_Total, fade_UserCreacion, fade_FechaCreacion)
VALUES (1, 1, 4, 80.00, 1, GETDATE()),
       (1, 2, 4, 60.00, 1, GETDATE());

-- Insertar en la tabla tbFacturasDetalles
INSERT INTO fact.tbFacturasDetalles (fact_Id, tick_Id, fade_Cantidad, fade_Total, fade_UserCreacion, fade_FechaCreacion)
VALUES (2, 2, 1, 40.00, 1, GETDATE()),
       (2, 2, 1, 30.00, 1, GETDATE());

--**********************************************************/TABLA DE FACTURAS DETALLE************************************************************************--


--**************************************************************/INSERT DE FACTURACIÓN************************************************************************--

--************************************************************************************************************************************************************--
