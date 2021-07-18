--Listar Pedidos Realizados em 2019
SELECT ped.num_pedido AS PEDIDO, ped.data_emissao AS EMISSAO, cli.nome AS CLIENTE, pro.nome AS PRODUTO,
 it.quantidade AS QUANTIDADE, (it.quantidade*pro.preco) AS PRECO,it.valor_unitario AS VALOR_UNITARIO, cat.nome AS CATEGORIA
    FROM pedidos ped
        JOIN clientes cli ON(ped.cod_cliente = cli.cod_cliente)
        JOIN itens_pedidos it ON(ped.num_pedido = it.num_pedido)
        JOIN produtos pro ON(it.cod_produto = pro.cod_produto)
        JOIN categorias cat ON(pro.cod_categoria= cat.cod_categoria)
        JOIN pessoas_fisicas pf ON(cli.cod_cliente=pf.cod_cliente)
    WHERE pf.genero = 'F' AND EXTRACT(YEAR FROM ped.data_emissao) = 2019
    ORDER BY ped.data_emissao DESC,cli.nome;

--Listar Clientes e suas respectivas idades ordenando por ordem alfabética
SELECT cli.nome AS NOME,TRUNC((MONTHS_BETWEEN(SYSDATE,pf.data_nascimento))/12) AS IDADE, ender.rua || ', ' || ender.numero || ', ' || 
    ender.complemento ||', ' || ender.cep || ', ' || cid.nome || ', ' || cid.uf || ', ' || est.nome || ', ' || est.regiao as ENDERECO
        FROM clientes cli
            JOIN pessoas_fisicas pf ON(cli.cod_cliente = pf.cod_cliente)
            JOIN enderecos ender ON(cli.cod_cliente = ender.cod_cliente)
            JOIN cidades cid ON(ender.cod_cidade = cid.cod_cidade)
            JOIN estados est ON(cid.uf = est.uf)
    ORDER BY cli.nome, IDADE desc;

--Listar Produtos e Categorizar referente ao seu tipo 
SELECT  pro.nome,
    CASE
        WHEN pro.preco<100 AND pro.importado = 'S' THEN cat.nome ||' - Produto Importado'
        WHEN pro.preco>=100 and pro.importado = 'S' THEN cat.nome || ' - Produto Importado Premium'
        WHEN pro.importado = 'N' THEN cat.nome || ' - Produto Nacional'
            END AS Categoria 
                FROM produtos pro
                    JOIN categorias cat ON(pro.cod_categoria = cat.cod_categoria);


--UPDATE MOVIMENTACOES PECAS
UPDATE movimento_pecas SET quantidade_movimentada = 18 WHERE num_movimentacao = 0001;

--DELETE PECAS
DELETE FROM pecas WHERE estoque=(SELECT MIN(estoque) FROM pecas) ;
DELETE FROM movimento_pecas WHERE cod_produto = (SELECT cod_produto FROM pecas WHERE estoque = (SELECT MIN(estoque) FROM pecas));
