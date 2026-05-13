

**DATA WAREHOUSE**

**NorthWind**

Descripcion del Proyecto

| Proyecto: | NorthWind Data Warehouse |
| :---- | :---- |
| **Version:** | 1.0.0 |
| **Fecha:** | Mayo 2026 |
| **Metodologia:** |  Modelo Estrella (Star Schema) |
| **Motor BD:** | Microsoft SQL Server 2016+ |

*Diseñado para analisis de ventas, rendimiento de empleados y logistica*

# **Tabla de Contenidos**

| 1\. | Resumen Ejecutivo | 3 |
| :---- | :---- | :---: |
| 2\. | Antecedentes y Contexto | 3 |
| 3\. | Objetivos del Proyecto | 4 |
| 4\. | Alcance | 4 |
| 5\. | Arquitectura del Data Warehouse | 5 |
| 6\. | Modelo Estrella \- Descripcion de Tablas | 5 |
| 7\. | Proceso ETL | 8 |


# **1\. Resumen Ejecutivo**

El presente proyecto consiste en el diseño, construccion y carga de un Data Warehouse corporativo a partir de la base de datos transaccional NorthWind de Microsoft. El objetivo central es transformar los datos operacionales dispersos en una estructura analitica optimizada, que permita a los usuarios de negocio responder preguntas estrategicas sobre ventas, clientes, productos y logistica de manera rapida y confiable.

El modelo implementado sigue la metodologia de Ralph Kimball (Star Schema), con una tabla de hechos central (FactSales) conectada a cinco dimensiones desnormalizadas. La solucion se ejecuta sobre Microsoft SQL Server y contempla un script ETL completo para la carga inicial desde NorthWind.

# **2\. Antecedentes y Contexto**

## **2.1 Base de Datos Fuente: NorthWind**

NorthWind es una base de datos de ejemplo de Microsoft que simula las operaciones de una empresa importadora/exportadora de alimentos. Contiene informacion sobre clientes, proveedores, productos, empleados, pedidos y envios. Su estructura es tipicamente OLTP (Online Transaction Processing), normalizada para minimizar la redundancia y optimizar las operaciones de escritura.

## **2.2 Problema que Resuelve el DW**

La base transaccional NorthWind presenta las siguientes limitaciones para el analisis:

* Consultas analiticas complejas requieren multiples JOINs entre 8 o mas tablas.

* No existe una dimension de tiempo que permita analisis temporales rapidos.

* Los datos de clientes, productos y empleados estan normalizados en multiples tablas.

* No hay un lugar centralizado para calcular metricas de ventas como el precio extendido o el flete proporcional.

* Las vistas existentes en NorthWind solo cubren periodos de 1997, limitando el analisis historico.

El Data Warehouse resuelve estos problemas consolidando los datos en un modelo desnormalizado, optimizado para lectura y analisis multidimensional (OLAP).

# **3\. Objetivos del Proyecto**

## **3.1 Objetivo General**

Construir un Data Warehouse en SQL Server que integre y consolide los datos operacionales de NorthWind en un modelo estrella, habilitando el analisis multidimensional de las ventas de la empresa.

## **3.2 Objetivos Especificos**

1. Disenar el modelo estrella identificando la tabla de hechos y las cinco dimensiones clave del negocio.

2. Implementar las tablas dimensionales con atributos desnormalizados y claves subrogadas.

3. Crear una dimension de fecha (DimDate).

4. Desarrollar el proceso ETL completo que extraiga, transforme y cargue los datos desde NorthWind hacia NorthWind\_DW.

5. Calcular metricas derivadas como ExtendedPrice y Freight proporcional directamente en la tabla de hechos.

6. Documentar el modelo, el proceso ETL y los casos de uso analiticos para los usuarios de negocio.

# **4\. Alcance**

## **4.1 Dentro del Alcance**

* Diseño e implementacion del modelo estrella con 1 tabla de hechos y 5 dimensiones.

* Script DDL completo para crear la base de datos NorthWind\_DW en SQL Server.

* Script ETL para carga inicial desde NorthWind a NorthWind\_DW.

* Generacion automatica de la dimension DimDate.

* Indices de rendimiento en todas las claves foraneas de FactSales.

* Consultas de ejemplo para los 4 casos de uso analiticos principales.


# **5\. Arquitectura del Data Warehouse**

## **5.1 Flujo de Datos**

| Capa Fuente |  | Proceso ETL |  | Capa Presentacion |
| ----- | :---: | ----- | :---: | ----- |
| NorthWind (OLTP)SQL Server | **→** | Scripts T-SQLINSERT/SELECT | **→** | NorthWind\_DW (OLAP)Modelo Estrella |

## **5.2 Herramientas y Tecnologias**

| Componente | Tecnologia |
| ----- | ----- |
| **Motor de base de datos** | Microsoft SQL Server 2016 o superior |
| **Lenguaje ETL** | T-SQL (Transact-SQL) |
| **Cliente SQL** | SQL Server Management Studio (SSMS) |
| **Base de datos fuente** | NorthWind (OLTP) |
| **Base de datos destino** | NorthWind\_DW (OLAP) |

# **6\. Modelo Estrella \- Descripcion de Tablas**

## **6.1 Tabla de Hechos: FactSales**

Es el nucleo del modelo. Almacena cada linea de pedido (combinacion unica de OrderID \+ ProductID) con sus metricas cuantificables. La granularidad es a nivel de linea de detalle de orden.

| Columna | Tipo | Descripcion |
| ----- | ----- | ----- |
| **ProductKey** | INT (FK) | Clave subrogada hacia DimProduct |
| **CustomerKey** | INT (FK) | Clave subrogada hacia DimCustomer |
| **EmployeeKey** | INT (FK) | Clave subrogada hacia DimEmployee |
| **ShipperKey** | INT (FK) | Clave subrogada hacia DimShipper |
| **OrderDateKey** | INT (FK) | Clave subrogada hacia DimDate (fecha del pedido) |
| **ShipDateKey** | INT (FK) | Clave subrogada hacia DimDate (fecha de envio, puede ser NULL) |
| **OrderID** | INT | Clave natural del pedido (trazabilidad) |
| **ProductID** | INT | Clave natural del producto (trazabilidad) |
| **UnitPrice** | MONEY | Precio unitario al momento del pedido |
| **Quantity** | SMALLINT | Cantidad de unidades vendidas |
| **Discount** | REAL | Porcentaje de descuento aplicado (0.0 a 1.0) |
| **ExtendedPrice** | MONEY | UnitPrice x Quantity x (1 \- Discount). Metrica principal. |
| **Freight** | MONEY | Flete proporcional por linea de pedido |
| **ShipName** | NVARCHAR(40) | Nombre del destinatario del envio (dim. degenerada) |
| **ShipCity** | NVARCHAR(15) | Ciudad de destino del envio |
| **ShipCountry** | NVARCHAR(15) | Pais de destino del envio |

## **6.2 DimProduct**

Consolida Products \+ Categories \+ Suppliers. Permite analisis por producto, categoria y proveedor sin JOINs adicionales.

| Columna | Tipo | Descripcion |
| ----- | ----- | ----- |
| **ProductKey** | INT (PK) | Clave subrogada (surrogate key) |
| **ProductID** | INT (NK) | Clave natural de la tabla Products |
| **ProductName** | NVARCHAR(40) | Nombre comercial del producto |
| **CategoryName** | NVARCHAR(15) | Nombre de la categoria (desnormalizado desde Categories) |
| **CategoryDesc** | NVARCHAR | Descripcion de la categoria |
| **SupplierName** | NVARCHAR(40) | Nombre del proveedor (desnormalizado desde Suppliers) |
| **SupplierCountry** | NVARCHAR(15) | Pais del proveedor |
| **UnitPrice** | MONEY | Precio unitario base del producto |
| **Discontinued** | BIT | Indica si el producto esta discontinuado |

## **6.3 DimCustomer**

Consolida Customers \+ CustomerDemographics. Permite segmentacion de clientes por pais, ciudad, region y perfil demografico.

| Columna | Tipo | Descripcion |
| ----- | ----- | ----- |
| **CustomerKey** | INT (PK) | Clave subrogada |
| **CustomerID** | NCHAR(5) NK | Clave natural de Customers |
| **CompanyName** | NVARCHAR(40) | Nombre de la empresa cliente |
| **ContactName** | NVARCHAR(30) | Nombre del contacto principal |
| **City** | NVARCHAR(15) | Ciudad del cliente |
| **Region** | NVARCHAR(15) | Region geografica del cliente |
| **Country** | NVARCHAR(15) | Pais del cliente |
| **CustomerDesc** | NVARCHAR | Descripcion del perfil demografico del cliente |

## **6.4 DimEmployee**

Consolida Employees \+ EmployeeTerritories \+ Territories \+ Region. Permite analisis de desempeno de ventas por vendedor y zona geografica.

| Columna | Tipo | Descripcion |
| ----- | ----- | ----- |
| **EmployeeKey** | INT (PK) | Clave subrogada |
| **EmployeeID** | INT (NK) | Clave natural de Employees |
| **FullName** | NVARCHAR(31) | Nombre completo del empleado |
| **Title** | NVARCHAR(30) | Titulo o cargo del empleado |
| **HireDate** | DATE | Fecha de contratacion |
| **Country** | NVARCHAR(15) | Pais donde opera el empleado |
| **ReportsToName** | NVARCHAR(31) | Nombre del supervisor directo |
| **TerritoryDescription** | NCHAR(50) | Descripcion del territorio asignado |
| **RegionDescription** | NCHAR(50) | Descripcion de la region de ventas |

## **6.5 DimDate**

Dimension de tiempo generada por script. Cubre el periodo 1990-01-01 al 2010-12-31 con granularidad diaria. Es fundamental para cualquier analisis temporal.

| Columna | Tipo | Descripcion |
| ----- | ----- | ----- |
| **DateKey** | INT (PK) | Clave en formato YYYYMMDD (ej: 19970101\) |
| **FullDate** | DATE | Fecha completa |
| **Year** | SMALLINT | Año (ej: 1997\) |
| **Quarter** | TINYINT | Trimestre del año (1 al 4\) |
| **QuarterName** | NVARCHAR(6) | Nombre del trimestre (Q1, Q2, Q3, Q4) |
| **Month** | TINYINT | Mes del año (1 al 12\) |
| **MonthName** | NVARCHAR(12) | Nombre del mes en ingles |
| **DayName** | NVARCHAR(12) | Nombre del dia de la semana |
| **IsWeekend** | BIT | 1 si es sabado o domingo, 0 si es dia laboral |

## **6.6 DimShipper**

Contiene los transportistas disponibles. Permite analizar que empresa de envio se utiliza mas y su relacion con el costo de flete.

| Columna | Tipo | Descripcion |
| ----- | ----- | ----- |
| **ShipperKey** | INT (PK) | Clave subrogada |
| **ShipperID** | INT (NK) | Clave natural de Shippers |
| **CompanyName** | NVARCHAR(40) | Nombre de la empresa transportista |
| **Phone** | NVARCHAR(24) | Telefono de contacto del transportista |

# **7\. Proceso ETL**

## **7.1 Descripcion General**

El proceso ETL (Extract, Transform, Load) se implementa mediante scripts T-SQL que se ejecutan directamente en SQL Server. Al ser una carga inicial, no se requiere manejo de incrementales ni control de duplicados avanzado. Las transformaciones se realizan en el mismo SELECT de insercion.

## **7.2 Orden de Ejecucion**

| Paso | Tabla Destino | Fuente | Transformacion Principal |
| ----- | ----- | ----- | ----- |
| 1 | **DimDate** | Generado por script | Calcular Year, Quarter, Month, DayName, IsWeekend |
| 2 | **DimProduct** | Products \+ Categories \+ Suppliers | Desnormalizar en una sola fila por producto |
| 3 | **DimCustomer** | Customers \+ CustomerCustomerDemo \+ CustomerDemographics | LEFT JOIN para incluir clientes sin perfil demografico |
| 4 | **DimEmployee** | Employees \+ EmployeeTerritories \+ Territories \+ Region | MIN(TerritoryID) para evitar duplicados por empleado |
| 5 | **DimShipper** | Shippers | Carga directa sin transformaciones |
| 6 | **FactSales** | OrderDetails \+ Orders \+ todas las dims | Lookup de claves subrogadas \+ calculo de ExtendedPrice y Freight proporcional |

## **7.3 Transformaciones Clave**

* ExtendedPrice: Se calcula como ROUND(UnitPrice \* Quantity \* (1 \- Discount), 2), equivalente a la formula usada en las vistas originales de NorthWind.

* Freight proporcional: El flete total de un pedido se divide entre el numero de lineas del mismo pedido para asignarlo proporcionalmente a cada fila de FactSales.

* DateKey: Las fechas se convierten al formato entero YYYYMMDD usando FORMAT() para coincidir con la clave primaria de DimDate.

* FullName en DimEmployee: Se construye concatenando FirstName \+ espacio \+ LastName usando LTRIM() para eliminar espacios sobrantes.

* ReportsToName: Se obtiene mediante un self-join a la tabla Employees para resolver el nombre del supervisor.


## **Integrantes:**

* 1 Gilmar Bautista Mamani
* 2 Andres Castro Mamani
* 3 Paola Andrea Ramirez sejas
* 4 André Sánchez Salazar
* 5 Cosmi Clemente Flores
