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
faixa_etaria INT,
tipo_cliente VARCHAR(100));

CREATE TABLE funcionarios(
id_funcionario INT PRIMARY KEY,
id_unidade FOREING KEY,
nome VARCHAR (150) NOT NULL,
cargo VARCHAR (100) NOT NULL,
departamento VARCHAR (100) NOT NULL,
salario DECIMAL (10,2)
data_admissao DATE,);

CREATE TABLE unidades (
id_unidade INT PRIMARY KEY,
nome_unidade VARCHAR(100) NOT NULL,
cidade  VARCHAR(100) NOT NULL,
regiao  VARCHAR(100) NOT NULL,
categoria_hotel  INT,
num_quartos_total INT);

CREATE TABLE tipos_quarto (
id_tipo_quarto INT PRIMARY KEY,
descricao VARCHAR (150),
capacidade_max INT,
valor_diaria_base DECIMAL (10,2));



SET GLOBAL local_infile = 1;


LOAD DATA INFILE "C:/Users/felipe.espirito/Downloads/naramarket_lojas.csv"
INTO TABLE canais_venda
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_canal, comissao_pct,)


LOAD DATA INFILE "C:/Users/felipe.espirito/Downloads/naramarket_produtos.csv"
INTO TABLE produtos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_produto, nome, categoria,preco);


LOAD DATA INFILE "C:/Users/felipe.espirito/Downloads/naramarket_vendas.csv"
INTO TABLE vendas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_venda, id_produto, id_loja, quantidade, valor, data_venda);

SELECT * FROM vendas
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

