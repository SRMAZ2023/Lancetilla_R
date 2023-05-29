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

--**************************************************************M�DULO DE ACCESO******************************************************************************--

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

--*************************************************************/M�DULO DE ACCESO******************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------



--***************************************************************M�DULO DE ZOOLOGICO**************************************************************************--

--**********************************************************TABLA DE �REA DEL ZOOLOGICOS**********************************************************************--
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
--*********************************************************/TABLA DE �REA DEL ZOOLOGICOS**********************************************************************--

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

--**************************************************************TABLA DE ALIMENTACI�N************************************************************************--
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
--*************************************************************/TABLA DE ALIMENTACI�N************************************************************************--

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ANIMALES**************************************************************************--
CREATE TABLE zool.tbAnimales(
anim_Id							INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
anim_Nombre						NVARCHAR(200)		NOT NULL,
anim_NombreCientifico			NVARCHAR(200)		NOT NULL,
anim_Reino						NVARCHAR(100)		NOT NULL,
habi_Id							INT					NOT NULL,
arzo_Id							INT					NOT NULL,
alim_Id							INT					NOT NULL,
espe_Id							INT					NOT NULL,

/**********Campos de auditoria***********/
anim_UserCreacion				INT,
anim_FechaCreacion				DATETIME			DEFAULT GETDATE(),
anim_UserModificacion			INT,
anim_FechaModificacion			DATETIME,
anim_Estado						BIT					DEFAULT 1,

CONSTRAINT FK_zool_tbAnimales_anim_UserCreacion_acce_tbUsuarios_usua_Id				FOREIGN KEY (anim_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_zool_tbAnimales_anim_UserModificacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (anim_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_zool_tbAnimales_arzo_Id_zool_tbAreasZoologico_arzo_Id					FOREIGN KEY (arzo_Id)					REFERENCES zool.tbAreasZoologico(arzo_Id),
CONSTRAINT FK_zool_tbAnimales_alim_Id_zool_tbAlimetacion_alim_Id					FOREIGN KEY (alim_Id)					REFERENCES zool.tbAlimentacion(alim_Id),
CONSTRAINT FK_zool_tbAnimales_habi_Id_zool_tbHabitat_habi_Id						FOREIGN KEY (habi_Id)					REFERENCES zool.tbHabitat(habi_Id),
CONSTRAINT FK_zool_tbAnimales_espe_Id_zool_tbEspecies_espe_Id						FOREIGN KEY (espe_Id)					REFERENCES zool.tbEspecies(espe_Id),
CONSTRAINT FK_zool_tbAnimales_anim_NombreCientifico									UNIQUE(anim_NombreCientifico));
--***************************************************************/TABLA DE ANIMALES*************************************************************************--

--**************************************************************/M�DULO DE ZOOLOGICO**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***********************************************************M�DULO DE MANTENIMIENTO**************************************************************************--

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
muni_Id					CHAR(4)					NOT NULL,

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

--**********************************************************/M�DULO DE MANTENIMIENTO**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------



--****************************************************************M�DULO DE BOT�NICA**************************************************************************--

--*************************************************************TABLA DE AREAS BOT�NICAS***********************************************************************--
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
--************************************************************/TABLA DE AREAS BOT�NICAS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE CUIDADOS***************************************************************************--
CREATE TABLE bota.tbCuidados(
cuid_Id					INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
cuid_Descripcion		NVARCHAR(100)		NOT NULL,
cuid_Frecuencia			NVARCHAR(100)		NOT NULL,

/**********Campos de auditoria***********/
cuid_UserCreacion		INT,
cuid_FechaCreacion		DATETIME			DEFAULT GETDATE(),
cuid_UserModificacion	INT,
cuid_FechaModificacion	DATETIME,
cuid_Estado				BIT					DEFAULT 1,

CONSTRAINT FK_bota_tbCuidad_cuid_UserCreacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (cuid_UserCreacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_bota_tbCuidad_cuid_UserModificacion_acce_tbUsuarios_usua_Id	FOREIGN KEY (cuid_UserModificacion) REFERENCES acce.tbUsuarios(usua_Id));
--****************************************************************/TABLA DE CUIDADOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE PLANTAS****************************************************************************--
CREATE TABLE bota.tbPlantas (
plan_Id					INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
plan_Nombre				NVARCHAR(100)		NOT NULL,
plan_NombreCientifico	NVARCHAR(200)		NOT NULL,
plan_Reino				NVARCHAR(100)		NOT NULL,
arbo_Id					INT					NOT NULL,
cuid_Id					INT					NOT NULL,

/**********Campos de auditoria***********/
plan_UserCreacion		INT,
plan_FechaCreacion		DATETIME			DEFAULT GETDATE(),
plan_UserModificacion	INT,
plan_FechaModificacion	DATETIME,
plan_Estado				BIT					DEFAULT 1,

CONSTRAINT FK_bota_tbPlantas_plan_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (plan_UserCreacion)			REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_bota_tbPlantas_plan_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (plan_UserModificacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_bota_tbPlantas_arbo_Id_bota_tbAreasBotanicas_arbo_Id				FOREIGN KEY (arbo_Id)					REFERENCES bota.tbAreasBotanicas(arbo_Id),
CONSTRAINT FK_bota_tbPlantas_cuid_Id_bota_tbCuidado_cuid_Id						FOREIGN KEY (cuid_Id)					REFERENCES bota.tbCuidados(cuid_Id),
CONSTRAINT UK_bota_tbPlantas_plan_NombreCientifico								UNIQUE(plan_NombreCientifico));
--****************************************************************/TABLA DE PLANTAS***************************************************************************--

--***************************************************************/M�DULO DE BOT�NICA**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***************************************************************M�DULO DE FACTURACI�N************************************************************************--

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

--*************************************************************TABLA DE M�TODOS DE PAGO***********************************************************************--
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

--************************************************************/TABLA DE M�TODOS DE PAGO***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE FACTURAS***************************************************************************--
CREATE TABLE fact.tbFacturas(
fact_Id							INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
empl_Id							INT					NOT NULL,
visi_Id							INT					NOT NULL,
meto_Id							INT					NOT NULL,
fact_Fecha						DATE				NOT NULL,

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

--**************************************************************/M�DULO DE FACTURACI�N************************************************************************--

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


  DECLARE @Pass AS NVARCHAR(MAX);
	SET @Pass = CONVERT(NVARCHAR(MAX), HASHBYTES('sha2_512', '123'), 2);


INSERT INTO acce.tbUsuarios(usua_NombreUsuario, empl_Id, usua_Clave, role_Id, usua_Admin, usua_UserCreacion)
VALUES 
  ('Admin', 1, @Pass, 1, 0, 1)

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

INSERT INTO acce.tbPantallas (pant_Descripcion, pant_UserCreacion, pant_FechaCreacion, pant_UserModificacion, pant_FechaModificacion)
VALUES ('Graficos', NULL, GETDATE(), NULL, NULL) --23
     
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
		(1,23,1,GETDATE()),
		
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

--**********************************************************TABLA DE �REA DEL ZOOLOGICOS**********************************************************************--
INSERT INTO zool.tbAreasZoologico (arzo_Descripcion, arzo_UserCreacion)
VALUES 
  ('Acuario', 1),
  ('Safari', 1),
  ('Jard�n de Aves', 1),
  ('Terrario', 1),
  ('Zona de Primates', 1),
  ('H�bitat de Felinos', 1),
  ('Aviario', 1),
  ('Granja Educativa', 1),
  ('Paseo de Reptiles', 1),
  ('Pabell�n de Mariposas', 1);
--*********************************************************/TABLA DE �REA DEL ZOOLOGICOS**********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE HABITATS***************************************************************************--
INSERT INTO zool.tbHabitat (habi_Descripcion, habi_UserCreacion)
VALUES 
    -- Aves
    ('Bosques templados', 1),
    
    -- Mam�feros
    ('Bosques', 1),
        
    -- Anfibios
    ('Bosques h�medos', 1),
    
    -- Peces
    ('Oc�anos', 1),
    
    -- Ar�cnidos
    ('Praderas', 1),
    
    -- Crust�ceos
    ('Estuarios', 1),
    
    -- Moluscos
    ('Lagos', 1),
    
    -- Primates
    ('Monta�as', 1),
    
    -- Cet�ceos
    ('Mares', 1),
    
    -- Roedores
    ('Zonas Urbanas', 1),
    
    -- Equinos
    ('Cuevas', 1),
    
    -- Caninos
    ('Jardines', 1),
    
    -- Felinos
    ('Selvas tropicales', 1),
    
    -- Reptiles acu�ticos
    ('R�os', 1),
    
    -- Reptiles terrestres
    ('Desiertos', 1);

--***************************************************************/TABLA DE HABITATS**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ESPECIES***************************************************************************--
INSERT INTO zool.tbEspecies (espe_Descripcion, espe_UserCreacion)
VALUES 
  ('Aves', 1),
  ('Mam�feros', 1),
  ('Reptiles', 1),
  ('Anfibios', 2),
  ('Peces', 1),
  ('Insectos', 1),
  ('Ar�cnidos', 1),
  ('Crust�ceos', 1),
  ('Moluscos', 1),
  ('Marsupiales', 1),
  ('Primates', 1),
  ('Cet�ceos', 1),
  ('Carn�voros', 1),
  ('Herb�voros', 1),
  ('Roedores', 1),
  ('Equinos', 1),
  ('Caninos', 1),
  ('Felinos', 1),
  ('Reptiles Acu�ticos', 1),
  ('Reptiles Terrestres', 1);
--***************************************************************/TABLA DE ESPECIES**************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE ALIMENTACI�N************************************************************************--
INSERT INTO zool.tbAlimentacion(alim_Descripcion, alim_UserCreacion)
VALUES 
  ('Semillas y frutas', 1),
  ('Carne y pescado', 1),
  ('Insectos y vegetales', 1),
  ('Insectos y peque�os vertebrados', 1),
  ('Alimento en escamas y pellets', 1),
  ('N�ctar y polen', 1),
  ('Insectos y peque�os invertebrados', 1),
  ('Alimento en escamas y vegetales', 1),
  ('Fitoplancton y zooplancton', 1),
  ('Frutas y peque�os insectos', 1),
  ('Frutas y hojas', 1),
  ('Peces y calamares', 1),
  ('Carne fresca', 1),
  ('Pasto y vegetales', 1),
  ('Semillas y nueces', 1),
  ('Hierbas y pasto', 1),
  ('Croquetas y carne de res', 1),
  ('Carne fresca y aves', 1),
  ('Peces y crust�ceos', 1),
  ('Insectos y peque�os mam�feros', 1);
--*************************************************************/TABLA DE ALIMENTACI�N************************************************************************--

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ANIMALES**************************************************************************--
INSERT INTO zool.tbAnimales (anim_Nombre, anim_NombreCientifico, anim_Reino, habi_Id, arzo_Id, alim_Id, espe_Id, anim_UserCreacion)
VALUES 
  -- Aves
  ('�guila Real', 'Aquila chrysaetos', 'Animalia', 8,7, 1, 1, 1),
  ('Colibr�', 'Trochilidae', 'Animalia',12, 7, 1, 1, 1),
  ('Avestruz', 'Struthio camelus', 'Animalia', 15, 2, 1, 1, 1),

  -- Mam�feros
  ('Tigre', 'Panthera tigris', 'Animalia', 13, 2, 2, 2, 1),
  ('Le�n', 'Panthera leo', 'Animalia', 12, 2, 2, 2, 1),
  ('Elefante', 'Loxodonta africana', 'Animalia', 2, 2, 2, 6, 1),

  -- Reptiles
  ('Tortuga Marina', 'Cheloniidae', 'Animalia', 4, 1, 3, 3, 1),
  ('Cocodrilo', 'Crocodylidae', 'Animalia', 14, 1, 3, 3, 1),

  -- Anfibios
  ('Rana Arbor�cola', 'Hyla versicolor', 'Animalia', 1, 9, 4, 4, 1),
  ('Salamandra', 'Salamandridae', 'Animalia',3, 9, 4, 4, 1),
  ('Sapo Com�n', 'Bufo bufo', 'Animalia', 12, 9, 4, 4, 1),

  -- Peces
  ('Salm�n', 'Salmo salar', 'Animalia', 14, 1, 5, 5, 1),
  ('Tibur�n Blanco', 'Carcharodon carcharias', 'Animalia', 4, 1, 5, 5, 1),
  ('Pez Payaso', 'Amphiprioninae', 'Animalia', 9, 1, 5, 5, 1),

  -- Insectos
  ('Mariposa Monarca', 'Danaus plexippus', 'Animalia', 12, 10, 6, 6, 1),
  ('Abeja de Miel', 'Apis mellifera', 'Animalia', 12, 4, 6, 6, 1),
  ('Escarabajo Rinoceronte', 'Dynastinae', 'Animalia', 13, 4, 6, 6, 1),

  -- Ar�cnidos
  ('Tar�ntula', 'Theraphosidae', 'Animalia', 13, 4, 7, 7, 1),
  ('Escorpi�n', 'Scorpiones', 'Animalia', 15, 4, 7, 7, 1),
  ('Viuda Negra', 'Latrodectus', 'Animalia', 5, 4, 7, 7, 1),

  -- Crust�ceos
  ('Cangrejo Rojo', 'Callinectes sapidus', 'Animalia', 4, 1, 8, 8, 1),
  ('Langosta', 'Palinuridae', 'Animalia', 9, 1, 8, 8, 1),
  ('Camaron', 'Pandalidae', 'Animalia', 9, 1, 8, 8, 1),

  -- Moluscos
  ('Caracol de Jard�n', 'Helix aspersa', 'Animalia', 2, 1, 9, 9, 1),
  ('Pulpo', 'Octopoda', 'Animalia', 4, 1, 9, 9, 1),
  ('Almeja', 'Bivalvia', 'Animalia', 9, 1, 9, 9, 1),

  -- Marsupiales
  ('Canguro Rojo', 'Macropus rufus', 'Animalia', 2, 2, 10, 10, 1),
  ('Koala', 'Phascolarctos cinereus', 'Animalia',2, 2, 10, 10, 1),
  ('Wombat', 'Vombatidae', 'Animalia', 2, 2, 10, 10, 1),

  -- Primates
  ('Gorila', 'Gorilla gorilla', 'Animalia', 8, 5, 11, 11, 1),
  ('Chimpanc�', 'Pan troglodytes', 'Animalia', 2, 5, 11, 11, 1),
  ('Orangut�n', 'Pongo abelii', 'Animalia', 1, 5, 11, 11, 1),

  -- Cet�ceos
  ('Ballena Azul', 'Balaenoptera musculus', 'Animalia', 4, 1, 12, 12, 1),
  ('Delf�n Nariz de Botella', 'Tursiops truncatus', 'Animalia', 4, 1, 12, 12, 1),
  ('Orca', 'Orcinus orca', 'Animalia', 4, 1, 12, 12, 1),

  -- Carn�voros
  ('Oso Polar', 'Ursus maritimus', 'Animalia', 3, 1, 13, 13, 1),
  ('Lobo', 'Canis lupus', 'Animalia', 5, 2, 13, 13, 1),

  -- Herv�boros
  ('Jirafa', 'Giraffa camelopardalis', 'Animalia', 5, 2, 14, 14, 1),
  ('Cebra', 'Equus quagga', 'Animalia', 5, 2, 14, 14, 1),

  -- Roedores
  ('Rat�n', 'Mus musculus', 'Animalia', 2, 4, 15, 15, 1),
  ('Ardilla', 'Sciurus vulgaris', 'Animalia', 2, 4, 15, 15, 1),
  ('Conejo', 'Oryctolagus cuniculus', 'Animalia', 5, 4, 15, 15, 1),

  -- Equinos
  ('Caballo', 'Equus ferus caballus', 'Animalia', 5, 4, 16, 16, 1),
  ('Cebra de Monta�a', 'Equus zebra', 'Animalia', 4, 4, 16, 16, 1),
  ('Asno', 'Equus africanus asinus', 'Animalia', 10, 4, 16, 16, 1),
    -- Caninos
  ('Perro', 'Canis lupas familiaris', 'Animalia',10, 4, 17, 17, 1),
  ('Coyote', 'Canis latrans', 'Animalia', 5, 4, 17, 17, 1),

    -- Felinos
  ('Pantera', 'Panthera pardus', 'Animalia', 8, 6, 18, 18, 1),
  ('Guepardo', 'Acinonyx jubatus', 'Animalia', 5, 6, 18, 18, 1),
  ('Jaguar', 'Panthera onca', 'Animalia', 13, 6, 18, 18, 1),

  -- Reptiles acu�ticos
  ('Tortuga de Gal�pagos', 'Chelonoidis nigra', 'Animalia', 8, 1, 19, 19, 1),
  ('Caim�n', 'Caimaninae', 'Animalia', 14, 1, 19, 19, 1),
  ('Serpiente Marina', 'Hydrophiinae', 'Animalia',4, 1, 19, 19, 1),

  -- Reptiles terrestres
  ('Drag�n de Komodo', 'Varanus komodoensis', 'Animalia', 13, 4, 20, 20, 1),
  ('Tortuga del Desierto', 'Gopherus agassizii', 'Animalia', 11, 4, 20, 20, 1),
  ('Camale�n', 'Chamaeleonidae', 'Animalia', 11, 9, 20, 20, 1);

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
  ('01','Atl�ntida', 1),
  ('02','Col�n', 1),
  ('03','Comayagua', 1),
  ('04','Cop�n', 1),
  ('05','Cort�s', 1),
  ('06','Choluteca', 1),
  ('07','El Para�so', 1),
  ('08','Francisco Moraz�n', 1),
  ('09','Gracias a Dios', 1),
  ('10','Intibuc�', 1),
  ('11','Islas de la Bah�a', 1),
  ('12','La Paz', 1),
  ('13','Lempira', 1),
  ('14','Ocotepeque', 1),
  ('15','Olancho', 1),
  ('16','Santa B�rbara', 1),
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
		 ('0204','02', 'Lim�n',					   1),
		 ('0205','02', 'Sab�',					   1),
		 ('0206','02', 'Santa F�',				   1),
		 ('0207','02', 'Santa Rosa de Agu�n',	   1),
		 ('0208','02', 'Sonaguera',				   1),
		 ('0209','02', 'Tocoa',					   1),
		 ('0210','02', 'Bonito Oriental',		   1),
		 ('0301','03', 'Comayagua',				   1),
		 ('0302','03', 'Ajuterique',				   1),
		 ('0303','03', 'El Rosario',				   1),
		 ('0304','03', 'Esqu�as',				   1),
		 ('0305','03', 'Humuya',					   1),
		 ('0306','03', 'La Libertad',			   1),
		 ('0307','03', 'Laman�',					   1),
		 ('0308','03', 'La Trinidad',			   1),
		 ('0309','03', 'Lejaman�',				   1),
		 ('0310','03', 'Meamb�r',				   1),
		 ('0311','03', 'Minas de Oro',			   1),
		 ('0312','03', 'Ojos de Agua',			   1),
		 ('0313','03', 'San Jer�nimo',			   1),
		 ('0314','03', 'San Jos� de Comayagua',	   1),
		 ('0315','03', 'San Jos� del Potrero',	   1),
		 ('0316','03', 'San Luis',				   1),
		 ('0317','03', 'San Sebasti�n',			   1),
		 ('0318','03', 'Siguatepeque',			   1),
		 ('0319','03', 'Villas de San Antonio',	   1),
		 ('0320','03', 'Las Lajas',				   1),
		 ('0321','03', 'Taulab�',				   1),
		 ('0401','04', 'Santa Rosa de Cop�n',	   1),
		 ('0402','04', 'Caba�as',				   1),
		 ('0403','04', 'Concepci�n',				   1),
		 ('0404','04', 'Cop�n Ruinas',			   1),
		 ('0405','04', 'Corqu�n',				   1),
		 ('0406','04', 'Cucuyagua',				   1),
		 ('0407','04', 'Dolores',				   1),
		 ('0408','04', 'Dulce Nombre',			   1),
		 ('0409','04', 'El Para�so',				   1),
		 ('0410','04', 'Florida',				   1),
		 ('0411','04', 'Lajigua',				   1),
		 ('0412','04', 'La Uni�n',				   1),
		 ('0413','04', 'Nueva Arcadia',			   1),
		 ('0414','04', 'San Agust�n',			   1),
		 ('0415','04', 'San Antonio',			   1),
		 ('0416','04', 'San Jer�nimo',			   1),
		 ('0417','04', 'San Jos�',				   1),
		 ('0418','04', 'San Juan de Ocoa',		   1),
		 ('0419','04', 'San Nicol�s',			   1),
		 ('0420','04', 'San Pedro',				   1),
		 ('0421','04', 'Santa Rita',				   1),
		 ('0422','04', 'Trinidad de Cop�n',		   1),
		 ('0423','04', 'Veracr�z',				   1),
		 ('0501','05', 'San Pedro Sula',			   1),
		 ('0502','05', 'Choloma',				   1),
		 ('0503','05', 'Omoa',					   1),
		 ('0504','05', 'Pimienta',				   1),
		 ('0505','05', 'Potrerillos',			   1),
		 ('0506','05', 'Puerto Cort�s',			   1),
		 ('0507','05', 'San Antonio de Cort�s',	   1),
	     ('0508','05', 'San Francisco de Yojoa',    1),
		 ('0509','05', 'San Manuel',				   1),
		 ('0510','05', 'Santa Cruz de Yoja',		   1),
		 ('0511','05', 'La Lima',				   1),
		 ('0601','06', 'Pascilagua',				   1),
		 ('0602','06', 'Comcepci�n de Mar�a',	   1),
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
		 ('0613','06', 'San Jos�',				   1),
		 ('0614','06', 'San Marcos de Col�n',	   1),
		 ('0615','06', 'Santa Ana de Yuscuare',	   1),
		 ('0701','07', 'Yuscar�n',				   1),
		 ('0702','07', 'Alauca',					   1),
		 ('0703','07', 'Danl�',					   1),
		 ('0704','07', 'El Para�so',				   1),
		 ('0705','07', 'Guinope',				   1),
		 ('0706','07', 'Jacaleapa',				   1),
		 ('0707','07', 'Liure',					   1),
		 ('0708','07', 'Morocel�',				   1),
		 ('0709','07', 'Oropol�',				   1),
		 ('0710','07', 'Potrerillos',			   1),
		 ('0711','07', 'San Antonio de Flores',	   1),
		 ('0712','07', 'San Lucas',				   1),		 
		 ('0713','07', 'San Mat�as',				   1),
		 ('0714','07', 'Soledad',				   1),
		 ('0715','07', 'Teupasenti',				   1),
		 ('0716','07', 'Texiguat',				   1),
		 ('0717','07', 'Vado Ancho',				   1),		
		 ('0718','07', 'Yauyupe',				   1),
		 ('0719','07', 'Trojes',					   1),
		 ('0801','08', 'Distrito Central',		   1),
		 ('0802','08', 'Alubar�n',				   1),
		 ('0803','08', 'Cedros',					   1),
		 ('0804','08', 'Cucar�n',				   1),
		 ('0805','08', 'El Porvenir',			   1),
		 ('0806','08', 'Guaimaca',				   1),
		 ('0807','08', 'La Libertad',			   1),
		 ('0808','08', 'La Venta',				   1),
		 ('0809','08', 'Lepaterique',			   1),
		 ('0810','08', 'Maraita',				   1),
		 ('0811','08', 'Maral�',					   1),
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
		 ('0823','08', 'Santa Luc�a',			   1),
		 ('0824','08', 'Talanga',				   1),
		 ('0825','08', 'Tatumbla',				   1),
		 ('0826','08', 'Valle de �ngeles',		   1),
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
		 ('1004','10', 'Concepci�n',				   1),
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
		 ('1015','10', 'Santa Luc�a',			   1),
		 ('1016','10', 'Yamaranguila',			   1),
		 ('1017','10', 'San Francisco de Opalaca',  1),
		 ('1101','11', 'Roat�n',					   1),
		 ('1102','11', 'Guanaja',				   1),
		 ('1103','11', 'Jos� Santos Guardiola',	   1),
		 ('1104','11', 'Utila',					   1),
		 ('1201','12', 'Aguanqueterique',		   1),
		 ('1202','12', 'Caba�as',				   1),
		 ('1203','12', 'Cane',					   1),
		 ('1204','12', 'Chinacla',				   1),
		 ('1205','12', 'Guagiquiro',				   1),
		 ('1206','12', 'Lauterique',				   1),
		 ('1207','12', 'Marcala',				   1),
		 ('1208','12', 'Mercedes de Oriente',	   1),
		 ('1209','12', 'Opatoro',				   1),
		 ('1210','12', 'San Antonio del Norte',	   1),
		 ('1211','12', 'San Jos�',				   1),
		 ('1212','12', 'San Juan',				   1),
		 ('1213','12', 'San Pedro de Tutule',	   1),
		 ('1214','12', 'Santa Ana',				   1),
		 ('1215','12', 'San Elena',				   1),
		 ('1216','12', 'Santa Mar�a',			   1),
		 ('1217','12', 'Santiago de Puringla',	   1),
		 ('1218','12', 'Yarula',					   1),
		 ('1301','13', 'Gracias',				   1),
		 ('1302','13', 'Bel�n',					   1),
		 ('1303','13', 'Candelaria',				   1),
		 ('1304','13', 'Cololaca',				   1),
		 ('1305','13', 'Erandique',				   1),
		 ('1306','13', 'Guascinse',				   1),
		 ('1307','13', 'Guarita',				   1),
		 ('1308','13', 'La Campa',				   1),
		 ('1309','13', 'La Iguala',				   1),
		 ('1310','13', 'Las Flores',				   1),
		 ('1311','13', 'La Uni�n',				   1),
		 ('1312','13', 'La Virtud',				   1),
		 ('1313','13', 'Lepaera',				   1),
		 ('1314','13', 'Mapulaca',				   1),
		 ('1315','13', 'Piraera',				   1),
		 ('1316','13', 'San Andr�s',				   1),
		 ('1317','13', 'San Francisco',			   1),
		 ('1318','13', 'San Juan Guarita',		   1),
		 ('1319','13', 'San Manuel Colohete',	   1),
		 ('1320','13', 'San Rafael',				   1),
		 ('1321','13', 'San Sebasti�n',			   1),
		 ('1322','13', 'Santa Cr�z',				   1),
		 ('1323','13', 'Talgua',					   1),
		 ('1324','13', 'Tambla',					   1),
		 ('1325','13', 'Tomal�',					   1),
		 ('1326','13', 'Valladolid',				   1),
		 ('1327','13', 'Virginia',				   1),
		 ('1328','13', 'San Marcos de Caiquin',	   1),
		 ('1401','14', 'Ocotepeque',				   1),
		 ('1402','14', 'Bel�n Gualcho',			   1),
		 ('1403','14', 'Concepci�n',				   1),
		 ('1404','14', 'Dolores Merend�n',		   1),
		 ('1405','14', 'Fraternidad',			   1),
		 ('1406','14', 'La Encarnaci�n',			   1),
		 ('1407','14', 'La Labor',				   1),
		 ('1408','14', 'Lucerna',				   1),
		 ('1409','14', 'Mercedes',				   1),
		 ('1410','14', 'San Fernando',			   1),
		 ('1411','14', 'San Francisco del Valle',   1),
		 ('1412','14', 'San Jorge',				   1),
		 ('1413','14', 'San Marcos',				   1),
		 ('1414','14', 'Santa F�',				   1),
		 ('1415','14', 'Sesenti',				   1),
		 ('1416','14', 'Sinuapa',				   1),
		 ('1501','15', 'Juticalpa',				   1),
		 ('1502','15', 'Campamento',				   1),
		 ('1503','15', 'Catacamas',				   1),
		 ('1504','15', 'Concordia',				   1),
		 ('1505','15', 'Dulce Nombre de Culm�',	   1),
		 ('1506','15', 'El Rosario',				   1),
		 ('1507','15', 'Esqu�pulas del Norte',	   1),
		 ('1508','15', 'Gualaco',				   1),
		 ('1509','15', 'Guarizama',				   1),
		 ('1510','15', 'Guata',					   1),
		 ('1511','15', 'Guayape',				   1),
		 ('1512','15', 'Jano',					   1),
		 ('1513','15', 'La Uni�n',				   1),
		 ('1514','15', 'Mangulile',				   1),
		 ('1515','15', 'Manto',					   1),
		 ('1516','15', 'Salam�',					   1),
		 ('1517','15', 'San Esteban',			   1),
		 ('1518','15', 'San Francisco de Becerra',  1),
		 ('1519','15', 'San Francisco de La Paz',   1),
		 ('1520','15', 'San Mar�a del Real',		   1),
		 ('1521','15', 'Silca',					   1),
		 ('1522','15', 'Yocon',					   1),
		 ('1523','15', 'Patuca',					   1),
		 ('1601','16', 'Santa B�rbara',			   1),
		 ('1602','16', 'Arada',					   1),
		 ('1603','16', 'Atima',					   1),
		 ('1604','16', 'Azacualpa',				   1),
		 ('1605','16', 'Ceguaca',				   1),
		 ('1606','16', 'Concepci�n del Norte',	   1),
		 ('1607','16', 'Concepci�n del Sur',		   1),
		 ('1608','16', 'Chinda',					   1),
		 ('1609','16', 'El N�spero',				   1),
		 ('1610','16', 'Gualala',				   1),
		 ('1611','16', 'Ilama',					   1),
		 ('1612','16', 'Las Vegas',				   1),
		 ('1613','16', 'Macuelizo',				   1),
		 ('1614','16', 'Naranjito',				   1),
		 ('1615','16', 'Nuevo Celilac',			   1),
		 ('1616','16', 'Nueva Frontera',			   1),
		 ('1617','16', 'Petoa',					   1),
		 ('1618','16', 'Protecci�n',				   1),
		 ('1619','16', 'Quimist�n',				   1),
		 ('1620','16', 'San Francisco de Ojuera',   1),
		 ('1621','16', 'San Jos� de Colinas',	   1),
		 ('1622','16', 'San Luis',				   1),
		 ('1623','16', 'San Marcos',				   1),
		 ('1624','16', 'San Nicol�s',			   1),
		 ('1625','16', 'San Pedro Zacapa',		   1),
		 ('1626','16', 'San Vicente Centenario',    1),
		 ('1627','16', 'Santa Rita',				   1),
		 ('1628','16', 'Trinidad',				   1),
		 ('1702','17', 'Nacome',					   1),
		 ('1703','17', 'Alianza',				   1),
		 ('1704','17', 'Amapala',				   1),
		 ('1705','17', 'Aramecina',				   1),
		 ('1706','17', 'Caridad',				   1),
		 ('1707','17', 'Goascor�n',				   1),
		 ('1701','17', 'Langue',					   1),
		 ('1708','17', 'San Francisco de Coray',    1),
		 ('1709','17', 'San Lorenzo',			   1),
		 ('1801','18', 'Yoro',					   1),
		 ('1802','18', 'Arenal',					   1),
		 ('1803','18', 'El Negrito',				   1),
		 ('1804','18', 'El Progreso',			   1),
		 ('1805','18', 'Joc�n',					   1),
		 ('1806','18', 'Moraz�n',				   1),
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
  ('Uni�n libre', 1),
  ('Separado', 1);
--**********************************************************/TABLA DE ESTADOS CIVILES*************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE CARGOS*****************************************************************************--
INSERT INTO mant.tbCargos(carg_Descripcion, carg_UserCreacion)
VALUES 
  ('Director del Zool�gico', 1),
  ('Curador de Animales', 1),
  ('Veterinario', 1),
  ('Encargado de Alimentaci�n', 1),
  ('Gu�a de Visitantes', 1);
--***************************************************************/TABLA DE CARGOS*****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE EMPLEADOS****************************************************************************--
INSERT INTO mant.tbEmpleados(empl_Nombre, empl_Apellido, empl_Identidad, empl_FechaNacimiento, empl_Direccion, empl_Sexo, empl_Telefono, estc_Id, carg_Id, muni_Id, empl_UserCreacion)
VALUES
('Juan', 'P�rez', '0801-1980-12345', '1980-01-08', 'Calle Principal 123', 'M', '9999-1234', 1, 1, '0201', 1),
('Mar�a', 'G�mez', '0502-1990-67890', '1990-02-05', 'Avenida Central 456', 'F', '8888-5678', 2, 2, '0202', 1),
('Carlos', 'L�pez', '0303-1985-45678', '1985-03-03', 'Colonia Los Pinos 789', 'M', '7777-9876', 1, 3, '0203', 2),
('Laura', 'Hern�ndez', '1004-1995-23456', '1995-04-10', 'Barrio El Bosque 567', 'F', '6666-2345', 3, 1, '0204', 2),
('Pedro', 'Rodr�guez', '0705-1982-34567', '1982-05-07', 'Residencial Las Flores 890', 'M', '5555-3456', 2, 2, '0205', 3),
('Ana', 'Torres', '2006-1993-45678', '1993-06-20', 'Colonia San Miguel 123', 'F', '4444-4567', 1, 3, '0206', 3),
('Luis', 'Mart�nez', '1507-1988-56789', '1988-07-15', 'Barrio La Esperanza 456', 'M', '3333-5678', 2, 1, '0207', 1),
('Sof�a', 'Garc�a', '1208-1998-67890', '1998-08-12', 'Residencial Los �ngeles 789', 'F', '2222-6789', 3, 2, '0208', 1),
('Jorge', 'D�az', '0909-1987-78901', '1987-09-09', 'Avenida Central Sur 234', 'M', '1111-7890', 1, 3, '0209', 1),
('Carolina', 'Ram�rez', '0410-1997-89012', '1997-10-04', 'Calle Los Alamos 567', 'F', '0000-8901', 2, 1, '0210', 1);
--*************************************************************/TABLA DE EMPLEADOS****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************/TABLA DE VISITANTES***************************************************************************--
INSERT INTO mant.tbVisitantes (visi_Nombres, visi_Apellido, visi_RTN, visi_Sexo, visi_UserCreacion)
VALUES 
  ('Mar�a', 'Gonz�lez', '0801199012345',  'F', 1),
  ('Carlos', 'L�pez', '0502198567890',    'M', 1),
  ('Laura', 'Hern�ndez', '0303199545678', 'F', 1),
  ('Pedro', 'Rodr�guez', '1004198223456', 'M', 1),
  ('Ana', 'Torres', '0705199334567',      'F', 1),
  ('Luis', 'Mart�nez', '2006198845678',   'M', 1),
  ('Sof�a', 'Garc�a', '1507199856789',    'F', 1),
  ('Jorge', 'D�az', '1208198767890',      'M', 1),
  ('Carolina', 'Ram�rez', '0909199778901','F', 1),
  ('Ricardo', 'S�nchez', '0410198589012', 'M', 1);
--*************************************************************/TABLA DE VISITANTES***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE TIPOS MANTENIMIENTO**********************************************************************--
INSERT INTO mant.tbTiposMantenimientos (tima_Descripcion, tima_UserCreacion)
VALUES
    ('Limpieza de jaula',1),
    ('Alimentaci�n de animales',1),
    ('Ba�o',1),
	('Curaci�n de animales',1),
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
    ('�uraci�n de herida al area de Felinos',									4,   1),
    ('Ba�o a las jirajas beb�s',												3, 1),
    ('Control de cucarachas',													5,   1),
    ('Curaci�n de la pata derecha de las cebras',								4,  1),
    ('Entrenamiento f�sico de los lobos',										6,  1),
    ('Curaci�n de infecci�n de los tigres',										4,    1),
    ('Limpieza de piscinas en el �rea de boas',									1,  1),
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


--****************************************************************INSERT DE BOT�NICA**************************************************************************--

--*************************************************************TABLA DE AREAS BOT�NICAS***********************************************************************--
INSERT INTO bota.tbAreasBotanicas (arbo_Descripcion, arbo_UserCreacion)
VALUES
    ('Jard�n de Cactus', 1),
    ('Orquideario', 1),
    ('Sendero de Plantas Tropicales', 1),
    ('Bosque de Con�feras', 1),
    ('Rosaleda', 1),
    ('Jard�n de Hierbas Arom�ticas', 1),
    ('Invernadero de Plantas Tropicales', 1),
    ('Huerto de Frutales', 1),
    ('Laberinto de Arbustos', 1),
    ('Estanque de Plantas Acu�ticas', 1);
--************************************************************/TABLA DE AREAS BOT�NICAS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE CUIDADOS***************************************************************************--
INSERT INTO bota.tbCuidados (cuid_Descripcion, cuid_Frecuencia, cuid_UserCreacion)
VALUES
    -- Jard�n de Cactus
    ('Riego moderado', '2 veces por semana', 1),
    ('Control de plagas', 'Mensual', 1),

    -- Orquideario
    ('Control de humedad', 'Semanal', 1),
    ('Fertilizaci�n espec�fica', 'Mensual', 1),

    -- Sendero de Plantas Tropicales
    ('Riego abundante', 'Diario', 1),
    ('Control de malezas', 'Semanal', 1),

    -- Bosque de Con�feras
    ('Mantenimiento de suelo �cido', 'Trimestral', 1),
    ('Podado de ramas secas', 'Anual', 1),

    -- Rosaleda
    ('Riego regular', '2 veces por semana', 1),
    ('Poda de rosales', 'Anual', 1),

    -- Jard�n de Hierbas Arom�ticas
    ('Riego adecuado', 'Seg�n necesidad', 1),
    ('Cosecha de hierbas', 'Seg�n necesidad', 1),

    -- Invernadero de Plantas Tropicales
    ('Mantenimiento de humedad', 'Diario', 1),
    ('Control de temperatura', 'Semanal', 1),

    -- Huerto de Frutales
    ('Riego adecuado', 'Seg�n necesidad', 1),
    ('Fertilizaci�n peri�dica', 'Mensual', 1),

    -- Laberinto de Arbustos
    ('Poda regular de arbustos', 'Anual', 1),
    ('Control de crecimiento', 'Seg�n necesidad', 1),

    -- Estanque de Plantas Acu�ticas
    ('Mantenimiento de calidad del agua', 'Semanal', 1),
    ('Control de algas', 'Seg�n necesidad', 1);

--****************************************************************/TABLA DE CUIDADOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE PLANTAS***************************************************************************--
INSERT INTO bota.tbPlantas (plan_Nombre, plan_NombreCientifico, plan_Reino, arbo_Id, cuid_Id, plan_UserCreacion)
VALUES
    -- Jard�n de Cactus
    ('Cactus de Navidad', 'Schlumbergera truncata', 'Plantae', 1, 1, 1),
    ('Cactus de Pascua', 'Hatiora gaertneri', 'Plantae', 1, 1, 1),

    -- Orquideario
    ('Orqu�dea Mariposa', 'Phalaenopsis spp.', 'Plantae', 2, 2, 1),
    ('Orqu�dea Cattleya', 'Cattleya spp.', 'Plantae', 2, 2, 1),

    -- Sendero de Plantas Tropicales
    ('Begonia Rex', 'Begonia rex-cultorum', 'Plantae', 3, 3, 1),
    ('Bananero', 'Musa spp.', 'Plantae', 3, 3, 1),

    -- Bosque de Con�feras
    ('Pino de Monterrey', 'Pinus radiata', 'Plantae', 4, 4, 1),
    ('Cedro del Atlas', 'Cedrus atlantica', 'Plantae', 4, 4, 1),

    -- Rosaleda
    ('Rosa del t�', 'Camellia sinensis', 'Plantae', 5, 5, 1),
    ('Rosa de Damasco', 'Rosa damascena', 'Plantae', 5, 5, 1),

    -- Jard�n de Hierbas Arom�ticas
    ('Menta', 'Mentha spp.', 'Plantae', 6, 6, 1),
    ('Albahaca', 'Ocimum basilicum', 'Plantae', 6, 6, 1),

    -- Invernadero de Plantas Tropicales
    ('Planta de Serpiente', 'Sansevieria trifasciata', 'Plantae', 7, 7, 1),
    ('Cala', 'Zantedeschia spp.', 'Plantae', 7, 7, 1),

    -- Huerto de Frutales
    ('Manzano', 'Malus domestica', 'Plantae', 8, 8, 1),
    ('Naranjo', 'Citrus sinensis', 'Plantae', 8, 8, 1),

    -- Laberinto de Arbustos
    ('Boj', 'Buxus spp.', 'Plantae', 9, 9, 1),
    ('Ligustro', 'Ligustrum spp.', 'Plantae', 9, 9, 1),

    -- Estanque de Plantas Acu�ticas
    ('Lirio de Agua', 'Nymphaea spp.', 'Plantae', 10, 10, 1),
    ('Papiro', 'Cyperus papyrus', 'Plantae', 10, 10, 1);

--****************************************************************/TABLA DE PLANTAS***************************************************************************--

--***************************************************************/M�DULO DE BOT�NICA**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***************************************************************INSERT DE FACTURACI�N************************************************************************--

--*****************************************************************TABLA DE TICKETS***************************************************************************--
INSERT INTO fact.tbTickets (tick_Descripcion, tick_Precio, tick_UserCreacion)
VALUES ('Ticket de entrada al zool�gico', 20.00, 1),
	   ('Ticket de entrada al jard�n bot�nico', 15.00, 1);

--****************************************************************/TABLA DE TICKETS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE M�TODOS DE PAGO***********************************************************************--
INSERT INTO fact.tbMetodosPago (meto_Descripcion, meto_UserCreacion)
VALUES
    ('Efectivo', 1),
    ('Tarjeta de cr�dito', 1),
    ('Tarjeta de d�bito', 1),
    ('Transferencia bancaria', 1),
    ('PayPal', 1),
    ('Cheque', 1),
    ('Vale de regalo', 1),
    ('Criptomoneda', 1),
    ('Pago m�vil', 1),
    ('Puntos de fidelidad', 1);
--************************************************************/TABLA DE M�TODOS DE PAGO***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE FACTURAS***************************************************************************--
INSERT INTO fact.tbFacturas (empl_Id, visi_Id, meto_Id, fact_Fecha, fact_UserCreacion)
VALUES (1, 1, 1, '2023-05-17', 1),
(2, 2, 2, '2023-05-17', 1),
(3, 3, 3, '2023-05-17', 1),
(4, 4, 4, '2023-05-17', 1),
(5, 5, 5, '2023-05-17', 1);

--***************************************************************/TABLA DE FACTURAS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE FACTURAS DETALLE************************************************************************--
/*PENDIENTE*/
--**********************************************************/TABLA DE FACTURAS DETALLE************************************************************************--

--**************************************************************/INSERT DE FACTURACI�N************************************************************************--

--************************************************************************************************************************************************************--
