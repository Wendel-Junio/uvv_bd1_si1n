-- Comando para excluir o usuário se existir.
DROP database IF EXISTS uvv;

-- Comando para excluir o usuário se existir.
DROP ROLE IF EXISTS wendel_j;

-- Criação do usuário.
CREATE USER wendel_j 
WITH ENCRYPTED PASSWORD '100298';

-- Criando o banco de dados uvv.
CREATE DATABASE uvv
OWNER = wendel_j
TEMPLATE template0
ENCODING 'UTF8'
LC_COLLATE 'pt_BR.UTF-8'
LC_CTYPE 'pt_BR.UTF-8'
allow_connections true; 

-- Dando os privilégios do banco de dados para o usuário.
GRANT ALL PRIVILEGES ON DATABASE uvv TO wendel_j; 

-- Comando para conectar ao banco de dados (UVV) com o usuário wendel_j
\c "dbname=uvv user=wendel_j password=1002986"

-- Criando o schema e dando a autorização para o usuário.
CREATE SCHEMA lojas AUTHORIZATION wendel_j; 

-- comando para habilitar o path para o schema (lojas).
SET SEARCH_PATH TO lojas, "$user", public;

-- Comando para mostrar o path que está sendo usado.
SHOW SEARCH_PATH;

-- Comando para setar o caminho para lojas.
ALTER USER wendel_j
SET SEARCH_PATH TO lojas, "$user", public;

-- Criação da tabela produtos
CREATE TABLE produtos (
                produto_id NUMERIC(38) 	NOT NULL,
                nome VARCHAR(255) 	NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
CONSTRAINT produto_id PRIMARY KEY (produto_id)
);

-- Criação dos comandos para os comentários da tabela produtos.
COMMENT ON TABLE  produtos IS 'tabela produtos.';
COMMENT ON COLUMN produtos.produto_id IS 'Coluna da chave primária da tabela produtos "produto_id", contendo o ID dos produtos.';
COMMENT ON COLUMN produtos.nome IS 'Coluna com o nome dos produtos.';
COMMENT ON COLUMN produtos.preco_unitario IS 'Coluna com o preço de cada produto.';
COMMENT ON COLUMN produtos.detalhes IS 'Coluna com os detalhes em binário de cada produto.';
COMMENT ON COLUMN produtos.imagem IS 'Coluna com a imagem em binário dos produtos.';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'Coluna com o tipo de arquivo no qual a imagem dos produtos é armazenada.';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Coluna com o link do arquivo das imagens dos produtos.';
COMMENT ON COLUMN produtos.imagem_charset IS 'Coluna com a codificação das imagens dos produtos.';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Coluna com a data da última atualização da imagem do produto.';

-- Criação da tabela lojas
CREATE TABLE lojas (
                loja_id NUMERIC(38) 	NOT NULL,
                nome VARCHAR(255) 	NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude  NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
CONSTRAINT loja_id PRIMARY KEY (loja_id)
);

-- Criação dos comandos para os comentários da tabela lojas.
COMMENT ON TABLE  lojas IS 'tabela lojas.';
COMMENT ON COLUMN lojas.loja_id IS 'Coluna da chave primária da tabela lojas "loja_id", contendo o ID das lojas.';
COMMENT ON COLUMN lojas.nome IS 'Coluna com o nome de cada loja.';
COMMENT ON COLUMN lojas.endereco_web IS 'Coluna com o link do site das lojas.';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Coluna com a localidade das lojas.';
COMMENT ON COLUMN lojas.latitude IS 'Coluna com a distância em graus até do equador das lojas';
COMMENT ON COLUMN lojas.longitude IS 'Coluna com a distância em graus até o meridiano de Greenwich de cada loja.';
COMMENT ON COLUMN lojas.logo IS 'Coluna com a logo das lojas.';
COMMENT ON COLUMN lojas.logo_mime_type IS 'Coluna com o tipo de arquivo na qual a logo é armazenada.';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Coluna com o link do arquivo das logos de cada loja.';
COMMENT ON COLUMN lojas.logo_charset IS 'Coluna com a codificação das logos.';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Coluna com a ultima data em que a logo foi alterada.';

-- Criação da tabela estoques.
CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);

-- Criação dos comandos para os comentários da tabela estoques.
COMMENT ON TABLE  estoques IS 'tabela estoques.';
COMMENT ON COLUMN estoques.estoque_id IS 'Coluna da chave primária da tabela estoques "estoque_id", contendo o ID dos estoques.';
COMMENT ON COLUMN estoques.loja_id IS 'Coluna da chave estrangeira da tabela estoques "loja_id", contendo o ID das lojas.';
COMMENT ON COLUMN estoques.produto_id IS 'Coluna da chave estrangeira da tabela estoques "produto_id", contendo o ID dos produtos.';
COMMENT ON COLUMN estoques.quantidade IS 'Coluna com a quantidade de produtos nos estoques das lojas.';

-- Criação da tabela clientes.
CREATE TABLE clientes (
                cliente_id NUMERIC(38) 	NOT NULL,
                email VARCHAR(255) 	NOT NULL,
                nome VARCHAR(255) 	NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);

-- Criação dos comandos para os comentários da tabela clientes.
COMMENT ON TABLE clientes IS 'tabela clientes.';
COMMENT ON COLUMN clientes.cliente_id IS 'Coluna da chave primária da tabela clientes "cliente_id", contendo o ID dos clientes.';
COMMENT ON COLUMN clientes.email IS 'coluna com o email dos clientes.';
COMMENT ON COLUMN clientes.nome IS 'Coluna com o nome dos clientes.';
COMMENT ON COLUMN clientes.telefone1 IS 'Coluna com o primeiro telefone dos clientes.';
COMMENT ON COLUMN clientes.telefone2 IS 'Coluna com o segundo telefone dos clientes.';
COMMENT ON COLUMN clientes.telefone3 IS 'Coluna com o terceiro telefone dos clientes.';

-- Criação da tabela envios.
CREATE TABLE envios (
                envio_id NUMERIC(38) 	NOT NULL,
                loja_id NUMERIC(38) 	NOT NULL,
                cliente_id NUMERIC(38) 	NOT NULL,
                endereco_entrega VARCHAR(512) 	NOT NULL,
                status VARCHAR(15) 	NOT NULL,
CONSTRAINT envio_id PRIMARY KEY (envio_id)
);

-- Criação dos comandos para os comentários da tabela envios.
COMMENT ON TABLE envios IS 'tabela envios.';
COMMENT ON COLUMN envios.envio_id IS 'Coluna da chave primária da tabela envios "envio_id", contendo o ID dos envios.';
COMMENT ON COLUMN envios.loja_id IS 'Coluna da chave estrangeira da tabela envios "loja_id", contendo o ID das lojas.';
COMMENT ON COLUMN envios.cliente_id IS 'Coluna da chave estrangeira da tabela envios "cliente_id", contendo o ID dos clientes.';
COMMENT ON COLUMN envios.endereco_entrega IS 'Coluna com o endereço que vai ser feita a entrega.';
COMMENT ON COLUMN envios.status IS 'Coluna com o status dos envios.';

-- Criação da tabela pedidos.
CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP 	NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);

-- Criação dos comandos para os comentários da tabela pedidos.
COMMENT ON TABLE  pedidos IS 'tabela pedidos.';
COMMENT ON COLUMN pedidos.pedido_id IS 'Coluna da chave primária da tabela pedidos "pedido_id", contendo o ID dos pedidos.';
COMMENT ON COLUMN pedidos.data_hora IS 'Coluna com a data e a hora de cada pedido.';
COMMENT ON COLUMN pedidos.cliente_id IS 'Coluna da chave estrangeira da tabela pedidos "cliente_id", contendo o ID dos clientes.';
COMMENT ON COLUMN pedidos.status IS 'Coluna com o status dos pedidos.';
COMMENT ON COLUMN pedidos.loja_id IS 'Coluna da chave estrangeira da tabela pedidos "loja_id", contendo o ID das lojas.';

-- Criação da tabela pedidos_itens.
CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) 	  NOT NULL,
                produto_id NUMERIC(38) 	  NOT NULL,
                numero_da_linha NUMERIC(38) 	  NOT NULL,
                preco_unitario NUMERIC(10,2) 	NOT NULL,
                quantidade NUMERIC(38) 	  NOT NULL,
                envio_id NUMERIC(38),
CONSTRAINT pedido_id_produto_id PRIMARY KEY (pedido_id, produto_id)
);

-- Criação dos comandos para os comentários da tabela pedidos_itens.
COMMENT ON TABLE pedidos_itens IS 'tabela relacional entre pedidos e produtos.';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Coluna da chave primária estrangeira da tabela pedidos_itens "pedido_id", contendo o ID dos pedidos.';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'Coluna da chave primária estrangeira da tabela pedidos_itens "produto_id", contendo o ID dos produtos.';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Coluna com o preço de cada pedido.';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'Coluna com a quantidade de produtos por pedido.';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'Coluna da chave estrangeira da tabela pedidos_itens "envio_id", contendo o ID dos envios.';

-- comando para alterar a tabela estoques adicionando a chave estrangeira "produto_id".
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para alterar a tabela pedidos_itens adicionando a chave estrangeira "produto_id".
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para alterar a tabela estoques adicionando a chave estrangeira "loja_id".
ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para alterar a tabela pedidos adicionando a chave estrangeira "loja_id".
ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para alterar a tabela envios adicionando a chave estrangeira "loja_id".
ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para alterar a tabela pedidos adicionando a chave estrangeira "cliente_id".
ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para alterar a tabela envios adicionando a chave estrangeira "cliente_id"
ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para alterar a tabela pedidos_itens adicionando a chave estrangeira "envio_id".
ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para alterar a tabela pedidos_itens adicionando a chave estrangeira "pedido_id".
ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para alterar a tabela pedidos adicionando uma constando para checar o status dos pedidos.
ALTER TABLE pedidos
ADD CONSTRAINT status_check_pedidos
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- comando para alterar a tabela envios adicionando uma constante para checar o status dos envios.
ALTER TABLE envios
ADD CONSTRAINT status_check_envios
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

-- comando para alterar a tabela lojas adicionando uma constante para que o endereço_web e o endereço fisico nao sejam nulos.
ALTER TABLE lojas
ADD CONSTRAINT endereco_check_lojas
CHECK ((endereco_web IS NOT NULL AND endereco_web <> '') OR (endereco_fisico IS NOT NULL AND endereco_fisico <> ''));



