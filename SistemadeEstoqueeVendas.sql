--Criando Tabelas do Banco de Dados de Estoque e Vendas--
CREATE TABLE categoria (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL
);
CREATE TABLE fornecedor (
  id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  telefone CHAR(15)
);
CREATE TABLE produto (
  id_produto INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  quantidade_estoque INT NOT NULL,
  id_categoria INT,
  id_fornecedor INT,
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
  FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor) 
);
CREATE TABLE venda (
  id_venda INT AUTO_INCREMENT PRIMARY KEY,
  data_venda DATE NOT NULL,
  valor_total DECIMAL(10,2) NOT NULL
);
CREATE TABLE item_venda (
  id_item INT AUTO_INCREMENT PRIMARY KEY,
  quantidade INT NOT NULL,
  preco_unitario DECIMAL(10,2) NOT NULL,
  id_venda INT,
  id_produto INT,
  FOREIGN KEY (id_venda) REFERENCES venda(id_venda),
  FOREIGN KEY (id_produto) REFERENCES produto(id_produto) 
);

--Inserindo Dados mas Tabelas--
INSERT INTO categoria (nome)
VALUES ('informática'), ('periféricos'), ('acessórios'), ('armazenamento'), ('componentes');

INSERT INTO fornecedor (nome, email, telefone)
VALUES ('Tech Distribuidora', 'contato@techdistribuidora.com', '11987654321'),
('InfoMais', 'contato@infomais.com', '11976543210'),
('Digital Supply', 'contato@digitalsupply.com', '11965432109'),
('MegaTech', 'contato@megatech.com', '11954321098'),
('Center Hardware', 'contato@centerhardware.com', '11943210987');

INSERT INTO produto (nome, preco, quantidade_estoque, id_categoria, id_fornecedor)
VALUES ('Notebook', '3500.00', '8', '1', '1'),
('Monitor 24', '899.90', '15', '2', '2'),
('Teclado Mecânico', '249.90', '20', '2', '3'),
('Mouse Gamer', '149.90', '30', '2', '3'),
('Headset', '199.90', '12', '2', '4'),
('Webcam', '179.90', '10', '2', '2'),
('Mousepad', '59.90', '35', '3', '4'),
('Cabo HDMI', '39.90', '50', '3', '1'),
('Adaptador USB', '49.90', '25', '3', '5'),
('SSD 480GB', '299.90', '18', '4', '5'),
('SSD 1TB', '499.90', '18', '4', '5'),
('HD Externo 1TB', '379.90', '4', '1', '2'),
('Memória RAM 8GB', '159.90', '22', '5', '1'),
('Memória RAM 16GB', '289.90', '14', '5', '4'),
('Placa de Vídeo', '2199.90', '5', '5', '5');

INSERT INTO venda (data_venda, valor_total)
VALUES ('2026/09/01', '399.80'),
('2026/09/02', '899.90'),
('2026/09/03', '649.70'),
('2026/09/04', '3500.00'),
('2026/09/05', '579.80'),
('2026/09/06', '799.80'),
('2026/09/08', '2199.90'),
('2026/09/10', '659.80');

INSERT INTO item_venda (quantidade, preco_unitario, id_venda, id_produto)
VALUES ('1', '249.90', '1', '1'),
('1', '149.90', '1', '2'),
('1', '899.90', '2', '3'),
('1', '149.90', '3', '4'),
('2', '349.90', '3', '5'),
('1', '3500.00', '4', '6'),
('1', '199.90', '1', '7'),
('2', '59.90', '1', '8'),
('3', '499.90', '1', '9'),
('1', '299.90', '1', '10'),
('1', '2199.90', '1', '11'),
('1', '289.90', '1', '12'),
('1', '159.90', '1', '13'),
('1', '149.90', '1', '14'),
('1', '59.90', '1', '15'),
('1', '49.90', '1', '16');

--Filtrando produtos com suas categorias--
SELECT produto.id_produto, produto.nome, produto.preco, produto.quantidade_estoque, categoria.nome
FROM produto
INNER JOIN categoria
ON produto.id_categoria = categoria.id_categoria;
--Filtrando produtos com seus fornecedores--
SELECT produto.id_produto, produto.nome AS produto, produto.preco AS preço, produto.quantidade_estoque AS estoque, fornecedor.nome AS fornecedor, fornecedor.email AS "e-mail do fornecedor"
FROM produto
INNER JOIN fornecedor
ON produto.id_fornecedor = fornecedor.id_fornecedor;
--Filtrando produtos com data de venda--
SELECT venda.id_venda, venda.data_venda AS data, produto.nome AS produto, item_venda.quantidade, item_venda.preco_unitario AS "preço unitário"
FROM venda
INNER JOIN item_venda
ON venda.id_venda = item_venda.id_venda
INNER JOIN produto
ON item_venda.id_produto = produto.id_produto;   
--Filtrando produtos de baixo estoque--
SELECT id_produto, nome AS produto, quantidade_estoque AS estoque
FROM produto
WHERE quantidade_estoque < 5
ORDER BY quantidade_estoque;




