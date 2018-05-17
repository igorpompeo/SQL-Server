-- criação do schema
create schema Pompeo;
go
-- criação da tabela
create table Pompeo.Operacoes(
	codigo int identity(1,1),
	op_data datetime,
	valor money,
	descricao VARCHAR(300));
go
-- criação da procedure deposita
create procedure Pompeo.deposita @Valor money = 50 as
insert into Pompeo.Operacoes values(GETDATE(), @Valor, 'Valor Depositado');
go
-- chamada da procedure e select na tabela
exec Pompeo.deposita;
select * from Pompeo.Operacoes;
-- exemplo de inserção
create or alter procedure Pompeo.deposita @Valor money = 50 as
begin
	if @Valor > 1000
	throw 50000, 'Valor deve ser menor que 1000', 1;
	insert into Pompeo.Operacoes values(getdate(), @Valor, 'Valor depositado');
end
go
--
select * from Pompeo.Operacoes