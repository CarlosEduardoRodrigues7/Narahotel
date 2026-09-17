CREATE DATABASE narahotel;

USE narahotel;

CREATE TABLE canais_de_venda (
 id_canal INT PRIMARY KEY,
 nome_canal VARCHAR(100) NOT NULL,
 comissao_pct DECIMAL(10,2));

CREATE TABLE clientes (
id_cliente INT PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
cidade_origem VARCHAR(100) NOT NULL,
estado_origem VARCHAR(100) NOT NULL,
faixa_etaria VARCHAR(150) NOT NULL,
tipo_cliente VARCHAR(100) NOT NULL);

DROP TABLE clientes;


CREATE TABLE unidades (
id_unidade INT PRIMARY KEY,
nome_unidade VARCHAR(100) NOT NULL,
cidade  VARCHAR(100) NOT NULL,
regiao  VARCHAR(100) NOT NULL,
categoria_hotel  INT NOT NULL,
num_quartos_total INT);


CREATE TABLE funcionarios(
id_funcionario INT PRIMARY KEY,
id_unidade INT,
nome VARCHAR (150) NOT NULL,
cargo VARCHAR (100) NOT NULL,
departamento VARCHAR (100) NOT NULL,
salario DECIMAL (10,2),
data_admissao DATE NOT NULL,
FOREIGN KEY (id_unidade)
REFERENCES unidades (id_unidade));


CREATE TABLE tipos_quarto (
id_tipo_quarto INT PRIMARY KEY,
descricao VARCHAR (150),
capacidade_max INT,
valor_diaria_base DECIMAL (10,2));

CREATE TABLE reservas (
id_reserva INT PRIMARY KEY,
id_unidade INT NOT NULL,
id_tipo_quarto INT NOT NULL,
id_cliente INT NOT NULL,
id_canal INT NOT NULL,
id_funcionario INT NOT NULL,
data_checkin DATE NOT NULL,
data_checkout DATE NOT NULL,
qtd_diarias INT NOT NULL,
num_hospedes INT NOT NULL,
avaliacao_hospede DECIMAL(10,2),
status_reserva VARCHAR(100),
forma_pagamento VARCHAR(100),
FOREIGN KEY (id_unidade)
REFERENCES unidades (id_unidade),
FOREIGN KEY (id_tipo_quarto)
REFERENCES tipos_quarto (id_tipo_quarto),
FOREIGN KEY (id_cliente)
REFERENCES clientes (id_cliente),
FOREIGN KEY (id_canal)
REFERENCES canais_de_venda(id_canal),
FOREIGN KEY (id_funcionario)
REFERENCES funcionarios (id_funcionario));



SET GLOBAL local_infile = 1;


LOAD DATA INFILE "C:/Users/felipe.espirito.SENACRJEDU/Downloads/canais_venda (1).csv"
INTO TABLE canais_de_venda
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_canal,nome_canal,comissao_pct);


LOAD DATA INFILE "C:/Users/felipe.espirito.SENACRJEDU/Downloads/clientes.concat.csv"
INTO TABLE clientes 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_cliente,nome,cidade_origem,estado_origem,faixa_etaria,tipo_cliente);



LOAD DATA INFILE "C:/Users/felipe.espirito.SENACRJEDU/Downloads/funcionarios.concat.csv"
INTO TABLE funcionarios
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_funcionario,id_unidade,nome,cargo,departamento,salario,data_admissao);




LOAD DATA INFILE "C:/Users/felipe.espirito.SENACRJEDU/Downloads/unidades.concat.csv"
INTO TABLE unidades
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_unidade,nome_unidade,cidade,regiao,categoria_hotel,num_quartos_total);




LOAD DATA INFILE "C:/Users/felipe.espirito.SENACRJEDU/Downloads/tipos_quarto.concat.csv"
INTO TABLE tipos_quarto
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_tipo_quarto,descricao,capacidade_max,valor_diaria_base);


LOAD DATA INFILE "C:/Users/felipe.espirito.SENACRJEDU/Downloads/reservas.concat (1).csv"
INTO TABLE reservas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_reserva,id_unidade,id_tipo_quarto,id_cliente,id_canal,data_checkin,data_checkout,qtd_diarias,num_hospedes,avaliacao_hospede,status_reserva,forma_pagamento);

SELECT * FROM reservas
WHERE valor > 100;


SELECT id_produto, valor FROM vendas
WHERE id_loja = 3;


SELECT id_produto, valor, data_venda FROM vendas
WHERE data_venda >= '2024-03-01'
AND data_venda <= '2024-03-31';

SELECT id_produto, valor FROM vendas
WHERE id_produto IN (5, 12, 47);


SELECT id_produto, SUM(valor) AS total_vendas
FROM vendas
GROUP BY id_produto
ORDER BY total_vendas DESC;


SELECT id_produto, SUM(valor) AS total_vendas
FROM vendas
WHERE data_venda >= "2024-06-01"
GROUP BY id_produto
HAVING total_vendas >= 10000
ORDER BY total_vendas DESC;


SELECT id_loja, COUNT(id_venda) AS quantidade
FROM vendas
GROUP BY id_loja;

