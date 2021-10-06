CREATE SCHEMA IF NOT EXISTS `tlv_final` DEFAULT CHARACTER SET utf8 ;
USE `tlv_final` ;

-- -----------------------------------------------------
-- Table `tlv_final`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlv_final`.`proveedores` (
  `id_proveedores` INT NOT NULL AUTO_INCREMENT,
  `representante_legal` VARCHAR(45) NOT NULL,
  `nombre_corporativo` VARCHAR(45) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_proveedores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tlv_final`.`telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlv_final`.`telefono` (
  `id_telefono` INT NOT NULL,
  `id_proveedores_telefono` INT NOT NULL,
  `recepcionista` VARCHAR(45) NOT NULL,
  `telefono1` VARCHAR(45) NOT NULL,
  `telefono2` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_telefono`),
  INDEX `fk_telefono_proveedores_idx` (`id_proveedores_telefono` ASC) VISIBLE,
  CONSTRAINT `fk_telefono_proveedores`
    FOREIGN KEY (`id_proveedores_telefono`)
    REFERENCES `tlv_final`.`proveedores` (`id_proveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tlv_final`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlv_final`.`cliente` (
  `id_cliente` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tlv_final`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlv_final`.`productos` (
  `id_productos` INT NOT NULL,
  `precio` INT NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `proveedor` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `stock` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_productos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tlv_final`.`proveedores_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlv_final`.`proveedores_has_productos` (
  `proveedores_id_proveedores` INT NOT NULL,
  `productos_id_productos` INT NOT NULL,
  PRIMARY KEY (`proveedores_id_proveedores`, `productos_id_productos`),
  INDEX `fk_proveedores_has_productos_productos1_idx` (`productos_id_productos` ASC) VISIBLE,
  INDEX `fk_proveedores_has_productos_proveedores1_idx` (`proveedores_id_proveedores` ASC) VISIBLE,
  CONSTRAINT `fk_proveedores_has_productos_proveedores1`
    FOREIGN KEY (`proveedores_id_proveedores`)
    REFERENCES `tlv_final`.`proveedores` (`id_proveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedores_has_productos_productos1`
    FOREIGN KEY (`productos_id_productos`)
    REFERENCES `tlv_final`.`productos` (`id_productos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


-- se insertan datos en las distintas tablas
SELECT * FROM tlv_final.cliente;

insert into cliente (nombre, apellido, direccion)
values
('Marcelino ','Villalba','Portezuelo-Trancoyan Km 20'),
('Gheorghe ','Maestre','Luis Cruz Martínez s/N'),
('Ignacio ','Cid','Málaga 115 Of. 1002'),
('Iria ','Badia','Teniente Merino Nº600.'),
('Mireya ','Sanchis','Avenida San Martín, 889');

SELECT * FROM tlv_final.productos;

insert into productos (id_productos, nombre_producto, precio, categoria, proveedor, color, stock)
values
(1,'teclado', 10900 ,'computacion','logitech','rojo',10),
(2,'switch', 300000 ,'electronica','nintendo','negro',5),
(3,'monitor', 180000 ,'setup','samsung','negro',6),
(4,'a30', 350000 ,'smartphone','lg','gris',15),
(5,'smart tv', 250000 ,'electronica','nintendo','negro',5),
(6,'mouse gamer', 50000 ,'computacion','logitech','rosado',2),
(7,'silla gamer', 185000 ,'electrohogar','technosit','blanco',10),
(8,'webcam', 30000 ,'setup','samsung','gris',2),
(9,'Equipo musica', 350000 ,'electrohogar','technosit','gris',10),
(10,'a21', 250000 ,'smartphone','lg','azul',90);

SELECT * FROM tlv_final.proveedores;

insert into proveedores (representante_legal, nombre_corporativo, categoria, correo)
values
('Maria Guzman','logitech','computacion','111@gmail.com'),
('Lorenzo Zurita','nintendo','electronica','222@gmail.com'),
('Yolanda Villena','lg','smartphone','333@gmail.com'),
('Jeronimo Valdes','samsung','setup','444@gmail.com'),
('Gracia Heredia','technosit','electrohogar','555@gmail.com');

SELECT * FROM tlv_final.telefono;

insert into telefono (id_telefono, id_proveedores_telefono, recepcionista, telefono1, telefono2)
values
(1,1,'Josefa Perez', '912344352','9654732322'),
(2,2,'Pablo Morales', '912344355','965473465'),
(3,3,'Ronald Madariaga', '912344372','9654733252'),
(4,4,'Daniela Herrera', '912344562','96547342'),
(5,5,'Tannia Varela', '912344378','965473432');

-- Cuál es la categoría de productos que más se repite. 
select categoria,count(*) from productos 
group by categoria
order by count(categoria) desc;

-- Cuáles son los productos con mayor stock. 
select nombre_producto, stock from productos 
group by stock
order by stock desc;

-- Qué color de producto es más común en nuestra tienda.
select color from productos 
group by color
order by count(color) desc;

-- Cual o cuales son los proveedores con menor stock de productos. 
select nombre_producto, proveedor, stock from productos
where stock = (select min(stock) from productos); 

-- Cambien la categoría de productos más popular por ‘Electrónica y computación’
SET SQL_SAFE_UPDATES = 0;
UPDATE productos SET
categoria='electrónica y computación'
WHERE categoria = 'computacion';
