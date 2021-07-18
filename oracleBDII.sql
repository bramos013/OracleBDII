--CRIACAO DAS TABELAS--

--Tabela ESTADOS
CREATE TABLE estados(
    uf CHAR(2) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    regiao CHAR(2) NOT NULL,
    CONSTRAINT pk_estados PRIMARY KEY(uf)
);
--Tabela CIDADES
CREATE TABLE cidades(
    cod_cidade NUMERIC(5) NOT NULL,
    nome VARCHAR(80) NOT NULL,
    uf CHAR(2) NOT NULL,
    CONSTRAINT pk_cidades PRIMARY KEY(cod_cidade)
);
--Tabela CLIENTES
CREATE TABLE clientes(
    cod_cliente NUMERIC(5) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_cadastro DATE DEFAULT SYSDATE NOT NULL,
    tipo CHAR(1) NOT NULL,
    CONSTRAINT pk_clientes PRIMARY KEY(cod_cliente)
);
--Tabela PESSOAS JURIDICAS
CREATE TABLE pessoas_juridicas(
    cod_cliente NUMERIC(5) NOT NULL,
    razao_social VARCHAR(100) NOT NULL,
    cnpj CHAR(13) NOT NULL,
    CONSTRAINT pk_clientesPJ PRIMARY KEY(cod_cliente),
    CONSTRAINT ak_clientePJ UNIQUE (cnpj)
);
--TABELA PESSOAS FISICAS
CREATE TABLE pessoas_fisicas(
    cod_cliente NUMERIC(5) NOT NULL,
    cpf CHAR(11) NOT NULL,
    genero CHAR(1) NOT NULL,
    data_nascimento DATE NOT NULL,
    cod_empresa NUMERIC(5),
    CONSTRAINT pk_clientesPF PRIMARY KEY(cod_cliente),
    CONSTRAINT ak_clientePF UNIQUE (cpf),
    CONSTRAINT chk_genero CHECK(genero IN('F','M'))
);
--Tabela CATEGORIAS
CREATE TABLE categorias(
    cod_categoria NUMERIC(2) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    cod_categoria_pai NUMERIC(2),
    CONSTRAINT pk_categorias PRIMARY KEY(cod_categoria)            
);
--Tabela PRODUTOS
CREATE TABLE produtos(
    cod_produto NUMERIC(3) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    data_lancamento DATE NOT NULL,
    importado CHAR(1) NOT NULL,
    preco NUMERIC(8,2) NOT NULL,
    prazo_entrega NUMERIC(3) NOT NULL,
    cod_categoria NUMERIC(2) NOT NULL,
    CONSTRAINT pk_produtos PRIMARY KEY(cod_produto)            
);
--Tabela PEDIDOS
CREATE TABLE pedidos(
    num_pedido NUMERIC(10) NOT NULL,
    data_emissao DATE DEFAULT SYSDATE NOT NULL,
    cod_cliente NUMERIC(5) NOT NULL,
    CONSTRAINT pk_pedidos PRIMARY KEY(num_pedido)                
);
--Tabela ITENS PEDIDOS
CREATE TABLE itens_pedidos(
    num_pedido NUMERIC(10) NOT NULL,
    cod_produto NUMERIC(3) NOT NULL,
    quantidade NUMERIC(4),
    valor_unitario NUMERIC(8,2),
    num_entrega NUMERIC(10),
    CONSTRAINT pk_itens_pedidos PRIMARY KEY(num_pedido,cod_produto)                
);
--Tabela ENTREGAS
CREATE TABLE entregas(
    num_entrega NUMERIC(10) NOT NULL,
    data DATE NOT NULL,
    placa CHAR(8) NOT NULL,
    mot_cnh NUMERIC(11) NOT NULL,
    mot_nome VARCHAR(100) NOT NULL,
    CONSTRAINT pk_entregas PRIMARY KEY(num_entrega)                
);
--Tabela ENDERECOS
CREATE TABLE enderecos(
    cod_cliente NUMERIC(5) NOT NULL,
    cod_endereco NUMERIC(2) NOT NULL,
    rua VARCHAR(80) NOT NULL,
    numero NUMERIC(6) NOT NULL,
    complemento VARCHAR(20),
    cep NUMERIC(8) NOT NULL,
    cod_cidade NUMERIC(5) NOT NULL,
    CONSTRAINT pk_enderecos PRIMARY KEY (cod_cliente,cod_endereco)    
);
--Tabela TELEFONES
CREATE TABLE telefones(
    id_telefone CHAR(10) NOT NULL,
    ddd NUMERIC(2) NOT NULL,
    numero NUMERIC(9) NOT NULL,
    cod_cliente NUMERIC(5) NOT NULL,
    CONSTRAINT pk_telefones PRIMARY KEY(id_telefone)
);
--Tabela PECAS EXERCICIO 4
CREATE TABLE pecas(
    cod_produto NUMERIC(6) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    preco NUMERIC(8,2) NOT NULL,
    peso NUMERIC(5) NOT NULL,
    estoque NUMERIC(6) NOT NULL,
    CONSTRAINT pk_cod_produto PRIMARY KEY(cod_produto)
);
--TABELA MOVIMENTO PECAS EXERCICIO 5
CREATE TABLE movimento_pecas(
    num_movimentacao NUMERIC(8) NOT NULL,
    cod_produto NUMERIC(6) NOT NULL,
    data DATE DEFAULT SYSDATE NOT NULL,
    quantidade_movimentada NUMERIC(6),
    tipo CHAR(1) NOT NULL,
    CONSTRAINT pk_num_movimentacao PRIMARY KEY(num_movimentacao),
    CONSTRAINT chk_entrada_saida CHECK(tipo='E' OR tipo='S')     
);

-- CHAVES PRIMARIAS
ALTER TABLE cidades ADD CONSTRAINT fk_estado_cidade FOREIGN KEY(uf) REFERENCES estados (uf);
ALTER TABLE enderecos ADD CONSTRAINT fk_cliente_endereco FOREIGN KEY(cod_cliente)REFERENCES clientes (cod_cliente);
ALTER TABLE enderecos ADD CONSTRAINT fk_cidade_endereco FOREIGN KEY (cod_cidade) REFERENCES cidades(cod_cidade);
ALTER TABLE produtos ADD CONSTRAINT fk_categoria_produto FOREIGN KEY(cod_categoria)REFERENCES categorias(cod_categoria);
ALTER TABLE pedidos ADD CONSTRAINT fk_cliente_pedido FOREIGN KEY(cod_cliente) REFERENCES clientes(cod_cliente);
ALTER TABLE itens_pedidos ADD CONSTRAINT fk_pedido_item_pedido FOREIGN KEY(num_pedido) REFERENCES pedidos(num_pedido);
ALTER TABLE itens_pedidos ADD CONSTRAINT fk_produto_item_pedido FOREIGN KEY(cod_produto)REFERENCES produtos(cod_produto);
ALTER TABLE pessoas_juridicas ADD CONSTRAINT fk_cliente_clientePJ FOREIGN KEY(cod_cliente) REFERENCES clientes(cod_cliente);
ALTER TABLE pessoas_fisicas ADD CONSTRAINT fk_cliente_clientePF FOREIGN KEY(cod_cliente) REFERENCES clientes(cod_cliente);
ALTER TABLE telefones ADD CONSTRAINT fk_cliente_telefone FOREIGN KEY(cod_cliente) REFERENCES clientes(cod_cliente);
ALTER TABLE pecas ADD CONSTRAINT fk_arrudaPro_pecas FOREIGN KEY(cod_produto) REFERENCES arruda.produtos(cod_produto);
ALTER TABLE movimento_pecas ADD CONSTRAINT fk_produto_codigo FOREIGN KEY(cod_produto) REFERENCES pecas(cod_produto) ON DELETE CASCADE;

--INSERTS BANCO

--ESTADOS
INSERT INTO estados VALUES('AC','Acre','N');
INSERT INTO estados VALUES('AL','Alagoas','NE');
INSERT INTO estados VALUES('AP','Amapa','N');
INSERT INTO estados VALUES('AM','Amazonas','N');
INSERT INTO estados VALUES('BA','Bahia','NE');
INSERT INTO estados VALUES('CE','Ceara','NE');
INSERT INTO estados VALUES('DF','Distrito Federal','CO');
INSERT INTO estados VALUES('ES','Espirito Santo','SE');
INSERT INTO estados VALUES('GO','Goias','CO');
INSERT INTO estados VALUES('MA','Maranhao','NE');
INSERT INTO estados VALUES('MG','Minas Gerais','SE');
INSERT INTO estados VALUES('MS','Mato Grosso do Sul','CO');
INSERT INTO estados VALUES('MT','Mato Grosso','CO');
INSERT INTO estados VALUES('PA','Para','N');
INSERT INTO estados VALUES('PB','Paraiba','NE');
INSERT INTO estados VALUES('PE','Pernambuco','NE');
INSERT INTO estados VALUES('PI','Piaui','NE');
INSERT INTO estados VALUES('PR','Parana','S');
INSERT INTO estados VALUES('RJ','Rio de Janeiro','SE');
INSERT INTO estados VALUES('RN','Rio Grande do Norte','NE');
INSERT INTO estados VALUES('RO','Rondonia','N');
INSERT INTO estados VALUES('RR','Roraima','N');
INSERT INTO estados VALUES('RS','Rio Grande do Sul','S');
INSERT INTO estados VALUES('SC','Santa Catarina','S');
INSERT INTO estados VALUES('SE','Sergipe','NE');
INSERT INTO estados VALUES('SP','Sao Paulo','SE');
INSERT INTO estados VALUES('TO','Tocantins','N');

--CIDADES
INSERT INTO cidades VALUES(1,'Rio Branco','AC');
INSERT INTO cidades VALUES(2,'Maceio','AL');
INSERT INTO cidades VALUES(3,'Macapa','AP');
INSERT INTO cidades VALUES(4,'Manaus','AM');
INSERT INTO cidades VALUES(5,'Salvador','BA');
INSERT INTO cidades VALUES(6,'Fortaleza','CE');
INSERT INTO cidades VALUES(7,'Brasilia','DF');
INSERT INTO cidades VALUES(8,'Vitoria','ES');
INSERT INTO cidades VALUES(9,'Goiania','GO');
INSERT INTO cidades VALUES(10,'Sao Luis','MA');
INSERT INTO cidades VALUES(11,'Cuiaba','MT');
INSERT INTO cidades VALUES(12,'Campo Grande','MS');
INSERT INTO cidades VALUES(13,'Belo Horizonte','MG');
INSERT INTO cidades VALUES(14,'Belem','PA');
INSERT INTO cidades VALUES(15,'Joao Pessoa','PB');
INSERT INTO cidades VALUES(16,'Curitiba','PR');
INSERT INTO cidades VALUES(17,'Recife','PE');
INSERT INTO cidades VALUES(18,'Teresina','PI');
INSERT INTO cidades VALUES(19,'Rio de Janeiro','RJ');
INSERT INTO cidades VALUES(20,'Natal','RN');
INSERT INTO cidades VALUES(21,'Porto Alegre','RS');
INSERT INTO cidades VALUES(22,'Porto Velho','RO');
INSERT INTO cidades VALUES(23,'Boa Vista','RR');
INSERT INTO cidades VALUES(24,'Florianopolis','SC');
INSERT INTO cidades VALUES(25,'Sao paulo','SP');
INSERT INTO cidades VALUES(26,'Aracaju','SE');

--CLIENTES
INSERT INTO clientes VALUES(1,'Andre','01/08/2014','F');
INSERT INTO clientes VALUES(2,'KR','23/07/2018','J');
INSERT INTO clientes VALUES(3,'Benicio','15/02/2013','F');
INSERT INTO clientes VALUES(4,'Boticas','03/04/2011','J');
INSERT INTO clientes VALUES(5,'Carolina','12/12/2015','F');
INSERT INTO clientes VALUES(6,'BRF','01/11/2011','J');
INSERT INTO clientes VALUES(7,'Douglas','01/08/2018','F');
INSERT INTO clientes VALUES(8,'OLAP','25/07/2011','J');
INSERT INTO clientes VALUES(9,'Maria','09/01/2013','F');
INSERT INTO clientes VALUES(10,'Klepler','25/05/2013','J');
INSERT INTO clientes VALUES(11,'Beatriz','12/05/2011','F');
INSERT INTO clientes VALUES(12,'Atacadinho','05/06/2004','J');
INSERT INTO clientes VALUES(13,'Sergio','17/01/2014','F');
INSERT INTO clientes VALUES(14,'Tubolandia','25/02/2018','J');

--PESSOAS JURIDICAS
INSERT INTO pessoas_juridicas VALUES(2,'KR Sindicos Profissionais ME','4580981200101');
INSERT INTO pessoas_juridicas VALUES(4,'ACME Logistica LTDA','7890981200101');
INSERT INTO pessoas_juridicas VALUES(6,'BRF Desenvolvimento de Soluçoes Eirelli','2500981212101');
INSERT INTO pessoas_juridicas VALUES(8,'OLAP Transportadora LTDA','2130981200101');
INSERT INTO pessoas_juridicas VALUES(10,'Kepler Industria e Comercio LTDA','4578981200122');
INSERT INTO pessoas_juridicas VALUES(12,'Atacadinho Dois Irmaos LTDA','2102216705401');
INSERT INTO pessoas_juridicas VALUES(14,'Cia de Conxeoes LTDA','2124298120011');

--PESSOAS FISICAS
INSERT INTO pessoas_fisicas VALUES(1,'0385893000','M','21/09/1981',2);
INSERT INTO pessoas_fisicas VALUES(3,'45792498624','M','31/01/1990',6);
INSERT INTO pessoas_fisicas VALUES(5,'65432875401','F','23/02/1994',null);
INSERT INTO pessoas_fisicas VALUES(7,'87215453605','M','12/04/1979',null);
INSERT INTO pessoas_fisicas VALUES(9,'5987456012','F','14/01/1960',null);
INSERT INTO pessoas_fisicas VALUES(11,'96472158964','F','25/09/2003',null);
INSERT INTO pessoas_fisicas VALUES(13,'14725632458','M','21/01/1987',null);

--ENDERECOS
INSERT INTO enderecos VALUES(1,10,'Rua Marcelo dos Santos',3056,null,94425255,1);
INSERT INTO enderecos VALUES(2,20,'Av. Ipiranga',721,null,71110721,1);
INSERT INTO enderecos VALUES(3,30,'Praca Governador Valadares',352,'Bloco 5 Apto 301',23057002,2);
INSERT INTO enderecos VALUES(4,40,'Rua Almirante Nascimento',55,null,81050954,3);
INSERT INTO enderecos VALUES(5,50,'Praca Castro Alves',22,'Bloco A Apto 19',07844021,4);
INSERT INTO enderecos VALUES(6,60,'Travessa Albertina Rigo',637,null,40112505,5);
INSERT INTO enderecos VALUES(7,70,'Av. Paraguassu',148,'Casa 2',6484621,1);
INSERT INTO enderecos VALUES(8,80,'Av. Da Serraria',245,null,97770010,1);
INSERT INTO enderecos VALUES(9,90,'Rua Campo Belo',195,null,23654896,1);

--TELEFONES
INSERT INTO telefones VALUES(4755947,51,985345692,1);
INSERT INTO telefones VALUES(5374813,51,40047676,2);
INSERT INTO telefones VALUES(314513,48,986786199,3);
INSERT INTO telefones VALUES(1367999,41,40026541,4);
INSERT INTO telefones VALUES(6428121,11,95232302,5);
INSERT INTO telefones VALUES(656890,71,32426888,6);
INSERT INTO telefones VALUES(313412,85,92336421,7);
INSERT INTO telefones VALUES(324211,43,32420000,8);
INSERT INTO telefones VALUES(86954,22,967890569,9);
INSERT INTO telefones VALUES(86321,11,32026464,10);
INSERT INTO telefones VALUES(86456,51,967890569,11);
INSERT INTO telefones VALUES(87878,21,34060609,12);
INSERT INTO telefones VALUES(84141,51,967890569,13);
INSERT INTO telefones VALUES(82525,31,30271414,14);

--PEDIDOS
INSERT INTO pedidos VALUES(1511564,'05/07/2018',5);
INSERT INTO pedidos VALUES(5424,'09/08/2018',3);
INSERT INTO pedidos VALUES(214545,'12/12/2019',1);
INSERT INTO pedidos VALUES(2132,'17/01/2020',1);
INSERT INTO pedidos VALUES(214,'04/05/2014',3);
INSERT INTO pedidos VALUES(7574,'03/07/2017',7);
INSERT INTO pedidos VALUES(6436,'08/06/2021',9);
INSERT INTO pedidos VALUES(4635,'04/06/2021',7);
INSERT INTO pedidos VALUES(156,'15/11/2019',11);
INSERT INTO pedidos VALUES(543,'14/03/2019',13);
INSERT INTO pedidos VALUES(641,'03/04/2019',9);
INSERT INTO pedidos VALUES(677,'22/04/2019',1);

--ENTREGAS
INSERT INTO entregas VALUES(2321,'09/07/2018','IUB-0577',5335361215,'Arthur');
INSERT INTO entregas VALUES(32523,'12/08/2018','IKM-6957',5152549579,'Mariano');
INSERT INTO entregas VALUES(6544,'16/12/2019','JKL-5201',5683865374,'Carlos');
INSERT INTO entregas VALUES(4536,'19/01/2020','AUX-9786',9040352741,'Joao');
INSERT INTO entregas VALUES(5432,'06/05/2014','IXL-9987',4401434369,'Andrei');
INSERT INTO entregas VALUES(43633,'04/07/2017','INV-2222',8730321963,'Bryan');
INSERT INTO entregas VALUES(87923,'11/06/2021','ISP-0030',3838384741,'Marcos');
INSERT INTO entregas VALUES(12329,'07/06/2021','ITL-4414',5196808123,'Felipe');
INSERT INTO entregas VALUES(3425,'18/11/2019','HEL-1444',5643267456,'Tiago');
INSERT INTO entregas VALUES(3241,'17/03/2019','XYZ-1321',989713546,'Luiz');
INSERT INTO entregas VALUES(7909,'05/04/2019','KLS-6075',647467872,'Renan');
INSERT INTO entregas VALUES(7777,'23/04/2019','HGH-8258',664423698,'Bruno');

--CATEGORIA
INSERT INTO categorias VALUES(1,'Eletronicos',null);
INSERT INTO categorias VALUES(2,'Esportes',0);
INSERT INTO categorias VALUES(3,'Camping',0);

--PRODUTOS
INSERT INTO produtos VALUES(123,'Tablet Samsung Tab 10','20/04/2019','S',299.99,5,1);
INSERT INTO produtos VALUES(563,'Barraca Para 4 Pessoas','14/11/2013','N',349.99,10,3);
INSERT INTO produtos VALUES(321,'Bola Nike Total 90 - Campo','22/04/2021','S',69.99,4,2);
INSERT INTO produtos VALUES(645,'Chuteira Adidas F50','11/06/2015','S',599.99,2,2);
INSERT INTO produtos VALUES(789,'Grill Cadence','01/05/2015','N',299.99,2,3);
INSERT INTO produtos VALUES(783,'Smartphone Samsung S21','01/05/2021','S',7599.99,2,1);
 
--ITENS PEDIDOS
INSERT INTO itens_pedidos VALUES(1511564,123,4,299.99,2321);
INSERT INTO itens_pedidos VALUES(5424,563,3,349.99,32523);
INSERT INTO itens_pedidos VALUES(214545,783,2,7599.99,6544);
INSERT INTO itens_pedidos VALUES(2132,123,2,299.99,4536);
INSERT INTO itens_pedidos VALUES(214,123,3,299.99,5432);
INSERT INTO itens_pedidos VALUES(7574,789,2,299.99,43633);
INSERT INTO itens_pedidos VALUES(6436,321,2,69.99,87923);
INSERT INTO itens_pedidos VALUES(4635,321,4,69.99,12329);
INSERT INTO itens_pedidos VALUES(156,123,3,299.99,3425);
INSERT INTO itens_pedidos VALUES(543,123,2,299.99,3241);
INSERT INTO itens_pedidos VALUES(641,645,2,599.99,7909);
INSERT INTO itens_pedidos VALUES(677,563,2,349.99,7777);

--PECAS
INSERT INTO pecas VALUES(123,'Display Para Samsung Tab',99.99,203,99);
INSERT INTO pecas VALUES(124,'Touch Samsung Tab',1299.99,111,16);

--MOVIMENTO PECAS
INSERT INTO movimento_pecas VALUES(0001,123,SYSDATE,7,'E');
INSERT INTO movimento_pecas VALUES(0002,123,SYSDATE,5,'S');
INSERT INTO movimento_pecas VALUES(0003,123,SYSDATE,9,'E');
INSERT INTO movimento_pecas VALUES(0004,124,SYSDATE,11,'S');
INSERT INTO movimento_pecas VALUES(0005,124,SYSDATE,3,'E');
INSERT INTO movimento_pecas VALUES(0006,124,SYSDATE,7,'S');
INSERT INTO movimento_pecas VALUES(0007,124,SYSDATE,5,'E');

COMMIT;