CREATE TABLE IF NOT EXISTS empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(150) UNIQUE NOT NULL,
    fecha_contratacion DATE NOT NULL,
    salario NUMERIC(10, 2) NOT NULL
);

INSERT INTO empleados (nombre, apellido, correo_electronico, fecha_contratacion, salario) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', '2023-01-15', 50000.00),
('María', 'Gómez', 'maria.gomez@example.com', '2023-02-20', 55000.00),
('Carlos', 'López', 'carlos.lopez@example.com', '2023-03-10', 60000.00);
