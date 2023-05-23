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
dept_Id					INT IDENTITY(1,1)		NOT NULL PRIMARY KEY,
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
muni_Id							INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
muni_Descripcion				NVARCHAR(100)		NOT NULL,
dept_Id INT NOT NULL,

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
muni_Id					INT					NOT NULL,

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
select GETDATE()
--*******************************************************TABLA DE MANTENIMIENTO POR ANIMAL********************************************************************--
CREATE TABLE mant.tbMantenimientoAnimal(
maan_Id					INT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
anim_Id					INT					NOT NULL,
mant_Id					INT					NOT NULL,
maan_Fecha				DATE				NOT NULL,

/**********Campos de auditoria***********/
maan_UserCreacion		INT,
maan_FechaCreacion		DATETIME			DEFAULT GETDATE(),
maan_UserModificacion	INT,
maan_FechaModificacion	DATETIME,
maan_Estado				BIT					DEFAULT 1,

CONSTRAINT FK_mant_tbMantenimientoAnimal_maan_UserModificacion_acce_tbUsuarios_usua_Id		FOREIGN KEY (maan_UserCreacion)		REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_mant_tbMantenimientoAnimal_maan_UserCreacion_acce_tbUsuarios_usua_Id			FOREIGN KEY (maan_UserModificacion) REFERENCES acce.tbUsuarios(usua_Id),
CONSTRAINT FK_mant_tbMantenimientoAnimal_mant_tbMantenimientos_mant_Id						FOREIGN KEY (mant_Id)				REFERENCES mant.tbMantenimientos(mant_Id),
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

INSERT INTO acce.tbUsuarios(usua_NombreUsuario, empl_Id, usua_Clave, role_Id, usua_Admin, usua_UserCreacion)
VALUES 
  ('juans', 1, '123', 1, 0, 1),
  ('selvin', 2, '123', 2, 0, 2),
  ('alex', 3, '123', 3, 1, 1);

--************************************************************/TABLA DE USUARIOS******************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE ROLES********************************************************************************--
INSERT INTO acce.tbRoles (role_Descripcion, role_UserCreacion)
VALUES 
  ('Digitador', 1),
  ('Visualizador', 2);
--*************************************************************/TABLA DE ROLES********************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--************************************************************TABLA DE PANTALLAS******************************************************************************--
/*PENDIENTE*/
--***********************************************************/TABLA DE PANTALLAS******************************************************************************--
----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*******************************************************TABLA DE ROLES POR PANTALLA**************************************************************************--
/*PENDIENTE*/
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

--****************************************************************TABLA DE ANIMALES**************************************************************************--
INSERT INTO zool.tbAnimales (anim_Nombre, anim_NombreCientifico, anim_Reino, habi_Id, arzo_Id, alim_Id, espe_Id, anim_UserCreacion)
VALUES 
  -- Aves
  ('Águila Real', 'Aquila chrysaetos', 'Animalia', 8,7, 1, 1, 1),
  ('Colibrí', 'Trochilidae', 'Animalia',12, 7, 1, 1, 1),
  ('Avestruz', 'Struthio camelus', 'Animalia', 15, 2, 1, 1, 1),

  -- Mamíferos
  ('Tigre', 'Panthera tigris', 'Animalia', 13, 2, 2, 2, 1),
  ('León', 'Panthera leo', 'Animalia', 12, 2, 2, 2, 1),
  ('Elefante', 'Loxodonta africana', 'Animalia', 2, 2, 2, 6, 1),

  -- Reptiles
  ('Tortuga Marina', 'Cheloniidae', 'Animalia', 4, 1, 3, 3, 1),
  ('Cocodrilo', 'Crocodylidae', 'Animalia', 14, 1, 3, 3, 1),

  -- Anfibios
  ('Rana Arborícola', 'Hyla versicolor', 'Animalia', 1, 9, 4, 4, 1),
  ('Salamandra', 'Salamandridae', 'Animalia',3, 9, 4, 4, 1),
  ('Sapo Común', 'Bufo bufo', 'Animalia', 12, 9, 4, 4, 1),

  -- Peces
  ('Salmón', 'Salmo salar', 'Animalia', 14, 1, 5, 5, 1),
  ('Tiburón Blanco', 'Carcharodon carcharias', 'Animalia', 4, 1, 5, 5, 1),
  ('Pez Payaso', 'Amphiprioninae', 'Animalia', 9, 1, 5, 5, 1),

  -- Insectos
  ('Mariposa Monarca', 'Danaus plexippus', 'Animalia', 12, 10, 6, 6, 1),
  ('Abeja de Miel', 'Apis mellifera', 'Animalia', 12, 4, 6, 6, 1),
  ('Escarabajo Rinoceronte', 'Dynastinae', 'Animalia', 13, 4, 6, 6, 1),

  -- Arácnidos
  ('Tarántula', 'Theraphosidae', 'Animalia', 13, 4, 7, 7, 1),
  ('Escorpión', 'Scorpiones', 'Animalia', 15, 4, 7, 7, 1),
  ('Viuda Negra', 'Latrodectus', 'Animalia', 5, 4, 7, 7, 1),

  -- Crustáceos
  ('Cangrejo Rojo', 'Callinectes sapidus', 'Animalia', 4, 1, 8, 8, 1),
  ('Langosta', 'Palinuridae', 'Animalia', 9, 1, 8, 8, 1),
  ('Camaron', 'Pandalidae', 'Animalia', 9, 1, 8, 8, 1),

  -- Moluscos
  ('Caracol de Jardín', 'Helix aspersa', 'Animalia', 2, 1, 9, 9, 1),
  ('Pulpo', 'Octopoda', 'Animalia', 4, 1, 9, 9, 1),
  ('Almeja', 'Bivalvia', 'Animalia', 9, 1, 9, 9, 1),

  -- Marsupiales
  ('Canguro Rojo', 'Macropus rufus', 'Animalia', 2, 2, 10, 10, 1),
  ('Koala', 'Phascolarctos cinereus', 'Animalia',2, 2, 10, 10, 1),
  ('Wombat', 'Vombatidae', 'Animalia', 2, 2, 10, 10, 1),

  -- Primates
  ('Gorila', 'Gorilla gorilla', 'Animalia', 8, 5, 11, 11, 1),
  ('Chimpancé', 'Pan troglodytes', 'Animalia', 2, 5, 11, 11, 1),
  ('Orangután', 'Pongo abelii', 'Animalia', 1, 5, 11, 11, 1),

  -- Cetáceos
  ('Ballena Azul', 'Balaenoptera musculus', 'Animalia', 4, 1, 12, 12, 1),
  ('Delfín Nariz de Botella', 'Tursiops truncatus', 'Animalia', 4, 1, 12, 12, 1),
  ('Orca', 'Orcinus orca', 'Animalia', 4, 1, 12, 12, 1),

  -- Carnívoros
  ('Oso Polar', 'Ursus maritimus', 'Animalia', 3, 1, 13, 13, 1),
  ('Lobo', 'Canis lupus', 'Animalia', 5, 2, 13, 13, 1),

  -- Hervíboros
  ('Jirafa', 'Giraffa camelopardalis', 'Animalia', 5, 2, 14, 14, 1),
  ('Cebra', 'Equus quagga', 'Animalia', 5, 2, 14, 14, 1),

  -- Roedores
  ('Ratón', 'Mus musculus', 'Animalia', 2, 4, 15, 15, 1),
  ('Ardilla', 'Sciurus vulgaris', 'Animalia', 2, 4, 15, 15, 1),
  ('Conejo', 'Oryctolagus cuniculus', 'Animalia', 5, 4, 15, 15, 1),

  -- Equinos
  ('Caballo', 'Equus ferus caballus', 'Animalia', 5, 4, 16, 16, 1),
  ('Cebra de Montaña', 'Equus zebra', 'Animalia', 4, 4, 16, 16, 1),
  ('Asno', 'Equus africanus asinus', 'Animalia', 10, 4, 16, 16, 1),
    -- Caninos
  ('Perro', 'Canis lupas familiaris', 'Animalia',10, 4, 17, 17, 1),
  ('Coyote', 'Canis latrans', 'Animalia', 5, 4, 17, 17, 1),

    -- Felinos
  ('Pantera', 'Panthera pardus', 'Animalia', 8, 6, 18, 18, 1),
  ('Guepardo', 'Acinonyx jubatus', 'Animalia', 5, 6, 18, 18, 1),
  ('Jaguar', 'Panthera onca', 'Animalia', 13, 6, 18, 18, 1),

  -- Reptiles acuáticos
  ('Tortuga de Galápagos', 'Chelonoidis nigra', 'Animalia', 8, 1, 19, 19, 1),
  ('Caimán', 'Caimaninae', 'Animalia', 14, 1, 19, 19, 1),
  ('Serpiente Marina', 'Hydrophiinae', 'Animalia',4, 1, 19, 19, 1),

  -- Reptiles terrestres
  ('Dragón de Komodo', 'Varanus komodoensis', 'Animalia', 13, 4, 20, 20, 1),
  ('Tortuga del Desierto', 'Gopherus agassizii', 'Animalia', 11, 4, 20, 20, 1),
  ('Camaleón', 'Chamaeleonidae', 'Animalia', 11, 9, 20, 20, 1);

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
INSERT INTO mant.tbDepartamentos(dept_Descripcion, dept_UserCreacion)
VALUES 
  ('Atlántida', 1),
  ('Colón', 1),
  ('Comayagua', 1),
  ('Copán', 1),
  ('Cortés', 1),
  ('Choluteca', 1),
  ('El Paraíso', 1),
  ('Francisco Morazán', 1),
  ('Gracias a Dios', 1),
  ('Intibucá', 1),
  ('Islas de la Bahía', 1),
  ('La Paz', 1),
  ('Lempira', 1),
  ('Ocotepeque', 1),
  ('Olancho', 1),
  ('Santa Bárbara', 1),
  ('Valle', 1),
  ('Yoro', 1);

--**********************************************************/TABLA DE DEPARTAMENTOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MUNICIPIOS****************************************************************************--
INSERT INTO mant.tbMunicipios(dept_Id, muni_Descripcion, muni_UserCreacion)
VALUES   ( 1, 'La Ceiba',				   1),
		 ( 1, 'Tela',					   1),
	     ( 1, 'La Masica',				   1),
		 ( 1, 'Arizona',				   1),
		 ( 1, 'Jutiapa',				   1),
		 ( 1, 'El Porvenir',			   1),
		 ( 1, 'Esparta',				   1),
	     ( 1, 'San Francisco',			   1),
		 ( 2, 'Trujillo',				   1),
		 ( 2, 'Balfate',				   1),
		 ( 2, 'Iriona',					   1),
		 ( 2, 'Limón',					   1),
		 ( 2, 'Sabá',					   1),
		 ( 2, 'Santa Fé',				   1),
		 ( 2, 'Santa Rosa de Aguán',	   1),
		 ( 2, 'Sonaguera',				   1),
		 ( 2, 'Tocoa',					   1),
		 ( 2, 'Bonito Oriental',		   1),
		 ( 3, 'Comayagua',				   1),
		 ( 3, 'Ajuterique',				   1),
		 ( 3, 'El Rosario',				   1),
		 ( 3, 'Esquías',				   1),
		 ( 3, 'Humuya',					   1),
		 ( 3, 'La Libertad',			   1),
		 ( 3, 'Lamaní',					   1),
		 ( 3, 'La Trinidad',			   1),
		 ( 3, 'Lejamaní',				   1),
		 ( 3, 'Meambár',				   1),
		 ( 3, 'Minas de Oro',			   1),
		 ( 3, 'Ojos de Agua',			   1),
		 ( 3, 'San Jerónimo',			   1),
		 ( 3, 'San José de Comayagua',	   1),
		 ( 3, 'San José del Potrero',	   1),
		 ( 3, 'San Luis',				   1),
		 ( 3, 'San Sebastián',			   1),
		 ( 3, 'Siguatepeque',			   1),
		 ( 3, 'Villas de San Antonio',	   1),
		 ( 3, 'Las Lajas',				   1),
		 ( 3, 'Taulabé',				   1),
		 ( 4, 'Santa Rosa de Copán',	   1),
		 ( 4, 'Cabañas',				   1),
		 ( 4, 'Concepción',				   1),
		 ( 4, 'Copán Ruinas',			   1),
		 ( 4, 'Corquín',				   1),
		 ( 4, 'Cucuyagua',				   1),
		 ( 4, 'Dolores',				   1),
		 ( 4, 'Dulce Nombre',			   1),
		 ( 4, 'El Paraíso',				   1),
		 ( 4, 'Florida',				   1),
		 ( 4, 'Lajigua',				   1),
		 ( 4, 'La Unión',				   1),
		 ( 4, 'Nueva Arcadia',			   1),
		 ( 4, 'San Agustín',			   1),
		 ( 4, 'San Antonio',			   1),
		 ( 4, 'San Jerónimo',			   1),
		 ( 4, 'San José',				   1),
		 ( 4, 'San Juan de Ocoa',		   1),
		 ( 4, 'San Nicolás',			   1),
		 ( 4, 'San Pedro',				   1),
		 ( 4, 'Santa Rita',				   1),
		 ( 4, 'Trinidad de Copán',		   1),
		 ( 4, 'Veracrúz',				   1),
		 ( 5, 'San Pedro Sula',			   1),
		 ( 5, 'Choloma',				   1),
		 ( 5, 'Omoa',					   1),
		 ( 5, 'Pimienta',				   1),
		 ( 5, 'Potrerillos',			   1),
		 ( 5, 'Puerto Cortés',			   1),
		 ( 5, 'San Antonio de Cortés',	   1),
	     ( 5, 'San Francisco de Yojoa',    1),
		 ( 5, 'San Manuel',				   1),
		 ( 5, 'Santa Cruz de Yoja',		   1),
		 ( 5, 'La Lima',				   1),
		 ( 6, 'Pascilagua',				   1),
		 ( 6, 'Comcepción de María',	   1),
		 ( 6, 'Duyure',					   1),
		 ( 6, 'El Corpues',				   1),
		 ( 6, 'El Triunfo',				   1),
		 ( 6, 'Marcovia',				   1),
		 ( 6, 'Morolica',				   1),
		 ( 6, 'Namasigue',				   1),
		 ( 6, 'Orocuina',				   1),
		 ( 6, 'Pespire',				   1),
		 ( 6, 'San Antonio de Flores',	   1),
		 ( 6, 'San Isidrio',			   1),
		 ( 6, 'San José',				   1),
		 ( 6, 'San Marcos de Colón',	   1),
		 ( 6, 'Santa Ana de Yuscuare',	   1),
		 ( 7, 'Yuscarán',				   1),
		 ( 7, 'Alauca',					   1),
		 ( 7, 'Danlí',					   1),
		 ( 7, 'El Paraíso',				   1),
		 ( 7, 'Guinope',				   1),
		 ( 7, 'Jacaleapa',				   1),
		 ( 7, 'Liure',					   1),
		 ( 7, 'Morocelí',				   1),
		 ( 7, 'Oropolí',				   1),
		 ( 7, 'Potrerillos',			   1),
		 ( 7, 'San Antonio de Flores',	   1),
		 ( 7, 'San Lucas',				   1),		 
		 ( 7, 'San Matías',				   1),
		 ( 7, 'Soledad',				   1),
		 ( 7, 'Teupasenti',				   1),
		 ( 7, 'Texiguat',				   1),
		 ( 7, 'Vado Ancho',				   1),		
		 ( 7, 'Yauyupe',				   1),
		 ( 7, 'Trojes',					   1),
		 ( 8, 'Distrito Central',		   1),
		 ( 8, 'Alubarén',				   1),
		 ( 8, 'Cedros',					   1),
		 ( 8, 'Cucarén',				   1),
		 ( 8, 'El Porvenir',			   1),
		 ( 8, 'Guaimaca',				   1),
		 ( 8, 'La Libertad',			   1),
		 ( 8, 'La Venta',				   1),
		 ( 8, 'Lepaterique',			   1),
		 ( 8, 'Maraita',				   1),
		 ( 8, 'Maralé',					   1),
		 ( 8, 'Nueva Armedia',			   1),
		 ( 8, 'Ojojona',				   1),
		 ( 8, 'Orica',					   1),
		 ( 8, 'Reitoca',				   1),
		 ( 8, 'Sabana Grande',			   1),
		 ( 8, 'San Antonio de Oriente',    1),
		 ( 8, 'San Buenaventura',		   1),
		 ( 8, 'San Ignacio',			   1),
		 ( 8, 'San Juan de Flores',		   1),
		 ( 8, 'San Miguelito',			   1),
		 ( 8, 'Santa Ana',				   1),
		 ( 8, 'Santa Lucía',			   1),
		 ( 8, 'Talanga',				   1),
		 ( 8, 'Tatumbla',				   1),
		 ( 8, 'Valle de Ángeles',		   1),
		 ( 8, 'Villas de San Fernando',    1),
		 ( 8, 'Vallecillo',				   1),
		 ( 9, 'Puerto Lempira',			   1),
		 ( 9, 'Brus Laguna',			   1),
		 ( 9, 'Hauas',					   1),
		 ( 9, 'Juan Francisco Bulnes',	   1),
		 ( 9, 'Villeda Morales',		   1),
		 ( 9, 'Wanpucirpe',				   1),
		 (10, 'La Esperanza',			   1),
		 (10, 'Camasca',				   1),
		 (10, 'Colomcagua',				   1),
		 (10, 'Concepción',				   1),
		 (10, 'Dolores',				   1),
		 (10, 'Intibuca',				   1),
		 (10, 'Jesus de Otoro',			   1),
		 (10, 'Magadalena',				   1),
		 (10, 'Masaguara',				   1),
		 (10, 'San Antonio',			   1),
		 (10, 'San Isidro',				   1),
		 (10, 'San Juan',				   1),
		 (10, 'San Marcos de la Sierra',   1),
		 (10, 'San Miguelito',			   1),
		 (10, 'Santa Lucía',			   1),
		 (10, 'Yamaranguila',			   1),
		 (10, 'San Francisco de Opalaca',  1),
		 (11, 'Roatán',					   1),
		 (11, 'Guanaja',				   1),
		 (11, 'José Santos Guardiola',	   1),
		 (11, 'Utila',					   1),
		 (12, 'Aguanqueterique',		   1),
		 (12, 'Cabañas',				   1),
		 (12, 'Cane',					   1),
		 (12, 'Chinacla',				   1),
		 (12, 'Guagiquiro',				   1),
		 (12, 'Lauterique',				   1),
		 (12, 'Marcala',				   1),
		 (12, 'Mercedes de Oriente',	   1),
		 (12, 'Opatoro',				   1),
		 (12, 'San Antonio del Norte',	   1),
		 (12, 'San José',				   1),
		 (12, 'San Juan',				   1),
		 (12, 'San Pedro de Tutule',	   1),
		 (12, 'Santa Ana',				   1),
		 (12, 'San Elena',				   1),
		 (12, 'Santa María',			   1),
		 (12, 'Santiago de Puringla',	   1),
		 (12, 'Yarula',					   1),
		 (13, 'Gracias',				   1),
		 (13, 'Belén',					   1),
		 (13, 'Candelaria',				   1),
		 (13, 'Cololaca',				   1),
		 (13, 'Erandique',				   1),
		 (13, 'Guascinse',				   1),
		 (13, 'Guarita',				   1),
		 (13, 'La Campa',				   1),
		 (13, 'La Iguala',				   1),
		 (13, 'Las Flores',				   1),
		 (13, 'La Unión',				   1),
		 (13, 'La Virtud',				   1),
		 (13, 'Lepaera',				   1),
		 (13, 'Mapulaca',				   1),
		 (13, 'Piraera',				   1),
		 (13, 'San Andrés',				   1),
		 (13, 'San Francisco',			   1),
		 (13, 'San Juan Guarita',		   1),
		 (13, 'San Manuel Colohete',	   1),
		 (13, 'San Rafael',				   1),
		 (13, 'San Sebastián',			   1),
		 (13, 'Santa Crúz',				   1),
		 (13, 'Talgua',					   1),
		 (13, 'Tambla',					   1),
		 (13, 'Tomalá',					   1),
		 (13, 'Valladolid',				   1),
		 (13, 'Virginia',				   1),
		 (13, 'San Marcos de Caiquin',	   1),
		 (14, 'Ocotepeque',				   1),
		 (14, 'Belén Gualcho',			   1),
		 (14, 'Concepción',				   1),
		 (14, 'Dolores Merendón',		   1),
		 (14, 'Fraternidad',			   1),
		 (14, 'La Encarnación',			   1),
		 (14, 'La Labor',				   1),
		 (14, 'Lucerna',				   1),
		 (14, 'Mercedes',				   1),
		 (14, 'San Fernando',			   1),
		 (14, 'San Francisco del Valle',   1),
		 (14, 'San Jorge',				   1),
		 (14, 'San Marcos',				   1),
		 (14, 'Santa Fé',				   1),
		 (14, 'Sesenti',				   1),
		 (14, 'Sinuapa',				   1),
		 (15, 'Juticalpa',				   1),
		 (15, 'Campamento',				   1),
		 (15, 'Catacamas',				   1),
		 (15, 'Concordia',				   1),
		 (15, 'Dulce Nombre de Culmí',	   1),
		 (15, 'El Rosario',				   1),
		 (15, 'Esquípulas del Norte',	   1),
		 (15, 'Gualaco',				   1),
		 (15, 'Guarizama',				   1),
		 (15, 'Guata',					   1),
		 (15, 'Guayape',				   1),
		 (15, 'Jano',					   1),
		 (15, 'La Unión',				   1),
		 (15, 'Mangulile',				   1),
		 (15, 'Manto',					   1),
		 (15, 'Salamá',					   1),
		 (15, 'San Esteban',			   1),
		 (15, 'San Francisco de Becerra',  1),
		 (15, 'San Francisco de La Paz',   1),
		 (15, 'San María del Real',		   1),
		 (15, 'Silca',					   1),
		 (15, 'Yocon',					   1),
		 (15, 'Patuca',					   1),
		 (16, 'Santa Bárbara',			   1),
		 (16, 'Arada',					   1),
		 (16, 'Atima',					   1),
		 (16, 'Azacualpa',				   1),
		 (16, 'Ceguaca',				   1),
		 (16, 'Concepción del Norte',	   1),
		 (16, 'Concepción del Sur',		   1),
		 (16, 'Chinda',					   1),
		 (16, 'El Níspero',				   1),
		 (16, 'Gualala',				   1),
		 (16, 'Ilama',					   1),
		 (16, 'Las Vegas',				   1),
		 (16, 'Macuelizo',				   1),
		 (16, 'Naranjito',				   1),
		 (16, 'Nuevo Celilac',			   1),
		 (16, 'Nueva Frontera',			   1),
		 (16, 'Petoa',					   1),
		 (16, 'Protección',				   1),
		 (16, 'Quimistán',				   1),
		 (16, 'San Francisco de Ojuera',   1),
		 (16, 'San José de Colinas',	   1),
		 (16, 'San Luis',				   1),
		 (16, 'San Marcos',				   1),
		 (16, 'San Nicolás',			   1),
		 (16, 'San Pedro Zacapa',		   1),
		 (16, 'San Vicente Centenario',    1),
		 (16, 'Santa Rita',				   1),
		 (16, 'Trinidad',				   1),
		 (17, 'Nacome',					   1),
		 (17, 'Alianza',				   1),
		 (17, 'Amapala',				   1),
		 (17, 'Aramecina',				   1),
		 (17, 'Caridad',				   1),
		 (17, 'Goascorán',				   1),
		 (17, 'Langue',					   1),
		 (17, 'San Francisco de Coray',    1),
		 (17, 'San Lorenzo',			   1),
		 (18, 'Yoro',					   1),
		 (18, 'Arenal',					   1),
		 (18, 'El Negrito',				   1),
		 (18, 'El Progreso',			   1),
		 (18, 'Jocón',					   1),
		 (18, 'Morazán',				   1),
		 (18, 'Olanchito',				   1),
		 (18, 'Santa Rita',				   1),
		 (18, 'Sulaco',					   1),
		 (18, 'Victoria',				   1),
		 (18, 'Yorito',					   1);
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
  ('Juan', 'Pérez', '0801-1980-12345', '1980-01-08', 'Calle Principal 123', 'M', '9999-1234', 1, 1, 1, 1),
  ('María', 'Gómez', '0502-1990-67890', '1990-02-05', 'Avenida Central 456', 'F', '8888-5678', 2, 2, 2, 1),
  ('Carlos', 'López', '0303-1985-45678', '1985-03-03', 'Colonia Los Pinos 789', 'M', '7777-9876', 1, 3, 3, 2),
  ('Laura', 'Hernández', '1004-1995-23456', '1995-04-10', 'Barrio El Bosque 567', 'F', '6666-2345', 3, 1, 4, 2),
  ('Pedro', 'Rodríguez', '0705-1982-34567', '1982-05-07', 'Residencial Las Flores 890', 'M', '5555-3456', 2, 2, 5, 3),
  ('Ana', 'Torres', '2006-1993-45678', '1993-06-20', 'Colonia San Miguel 123', 'F', '4444-4567', 1, 3, 6, 3),
  ('Luis', 'Martínez', '1507-1988-56789', '1988-07-15', 'Barrio La Esperanza 456', 'M', '3333-5678', 2, 1, 7, 1),
  ('Sofía', 'García', '1208-1998-67890', '1998-08-12', 'Residencial Los Ángeles 789', 'F', '2222-6789', 3, 2, 8, 1),
  ('Jorge', 'Díaz', '0909-1987-78901', '1987-09-09', 'Avenida Central Sur 234', 'M', '1111-7890', 1, 3, 9, 1),
  ('Carolina', 'Ramírez', '0410-1997-89012', '1997-10-04', 'Calle Los Alamos 567', 'F', '0000-8901', 2, 1, 10, 1);
--*************************************************************/TABLA DE EMPLEADOS****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************/TABLA DE VISITANTES***************************************************************************--
INSERT INTO mant.tbVisitantes (visi_Nombres, visi_Apellido, visi_RTN, visi_Sexo, visi_UserCreacion)
VALUES 
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
INSERT INTO mant.tbMantenimientoAnimal(anim_Id, mant_Id, maan_Fecha,maan_UserCreacion)
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

--*****************************************************************TABLA DE CUIDADOS***************************************************************************--
INSERT INTO bota.tbCuidados (cuid_Descripcion, cuid_Frecuencia, cuid_UserCreacion)
VALUES
    -- Jardín de Cactus
    ('Riego moderado', '2 veces por semana', 1),
    ('Control de plagas', 'Mensual', 1),

    -- Orquideario
    ('Control de humedad', 'Semanal', 1),
    ('Fertilización específica', 'Mensual', 1),

    -- Sendero de Plantas Tropicales
    ('Riego abundante', 'Diario', 1),
    ('Control de malezas', 'Semanal', 1),

    -- Bosque de Coníferas
    ('Mantenimiento de suelo ácido', 'Trimestral', 1),
    ('Podado de ramas secas', 'Anual', 1),

    -- Rosaleda
    ('Riego regular', '2 veces por semana', 1),
    ('Poda de rosales', 'Anual', 1),

    -- Jardín de Hierbas Aromáticas
    ('Riego adecuado', 'Según necesidad', 1),
    ('Cosecha de hierbas', 'Según necesidad', 1),

    -- Invernadero de Plantas Tropicales
    ('Mantenimiento de humedad', 'Diario', 1),
    ('Control de temperatura', 'Semanal', 1),

    -- Huerto de Frutales
    ('Riego adecuado', 'Según necesidad', 1),
    ('Fertilización periódica', 'Mensual', 1),

    -- Laberinto de Arbustos
    ('Poda regular de arbustos', 'Anual', 1),
    ('Control de crecimiento', 'Según necesidad', 1),

    -- Estanque de Plantas Acuáticas
    ('Mantenimiento de calidad del agua', 'Semanal', 1),
    ('Control de algas', 'Según necesidad', 1);

--****************************************************************/TABLA DE CUIDADOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE PLANTAS***************************************************************************--
INSERT INTO bota.tbPlantas (plan_Nombre, plan_NombreCientifico, plan_Reino, arbo_Id, cuid_Id, plan_UserCreacion)
VALUES
    -- Jardín de Cactus
    ('Cactus de Navidad', 'Schlumbergera truncata', 'Plantae', 1, 1, 1),
    ('Cactus de Pascua', 'Hatiora gaertneri', 'Plantae', 1, 1, 1),

    -- Orquideario
    ('Orquídea Mariposa', 'Phalaenopsis spp.', 'Plantae', 2, 2, 1),
    ('Orquídea Cattleya', 'Cattleya spp.', 'Plantae', 2, 2, 1),

    -- Sendero de Plantas Tropicales
    ('Begonia Rex', 'Begonia rex-cultorum', 'Plantae', 3, 3, 1),
    ('Bananero', 'Musa spp.', 'Plantae', 3, 3, 1),

    -- Bosque de Coníferas
    ('Pino de Monterrey', 'Pinus radiata', 'Plantae', 4, 4, 1),
    ('Cedro del Atlas', 'Cedrus atlantica', 'Plantae', 4, 4, 1),

    -- Rosaleda
    ('Rosa del té', 'Camellia sinensis', 'Plantae', 5, 5, 1),
    ('Rosa de Damasco', 'Rosa damascena', 'Plantae', 5, 5, 1),

    -- Jardín de Hierbas Aromáticas
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

    -- Estanque de Plantas Acuáticas
    ('Lirio de Agua', 'Nymphaea spp.', 'Plantae', 10, 10, 1),
    ('Papiro', 'Cyperus papyrus', 'Plantae', 10, 10, 1);

--****************************************************************/TABLA DE PLANTAS***************************************************************************--

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

--**************************************************************/INSERT DE FACTURACIÓN************************************************************************--

--************************************************************************************************************************************************************--
