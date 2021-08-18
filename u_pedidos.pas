unit u_pedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DBTables, Provider, DB, DBClient, Grids,
  DBGrids, Mask, DBCtrls;

type
  TFrm_pedidos = class(TForm)
    pnl_topo: TPanel;
    pnl_central: TPanel;
    lbl_total_pedido: TLabel;
    edt_cod_cliente: TEdit;
    edt_cod_produto: TEdit;
    edt_qtde: TEdit;
    edt_vlr_unitario: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btn_inserir: TBitBtn;
    dbg_itens_pedido: TDBGrid;
    ds_itens_pedido: TDataSource;
    cds_itens_pedido: TClientDataSet;
    dsp_itens_pedido: TDataSetProvider;
    q_itens_pedido: TQuery;
    cds_itens_pedidoCOD_PRODUTO: TFloatField;
    cds_itens_pedidoDESCRICAO: TStringField;
    cds_itens_pedidoQTDE: TFloatField;
    cds_itens_pedidoVLR_UNIT: TFloatField;
    cds_itens_pedidoVLR_TOTAL: TFloatField;
    dbe_nome: TDBEdit;
    dbe_produto: TDBEdit;
    q_cliente: TQuery;
    q_produto: TQuery;
    ds_cliente: TDataSource;
    ds_produto: TDataSource;
    btn_sair: TBitBtn;
    btn_gravar_pedido: TBitBtn;
    q_busca_prox_nro_pedido: TQuery;
    q_grava_pedido: TQuery;
    q_grava_itens_pedido: TQuery;
    btn_pesq_pedido: TBitBtn;
    edt_nro_pedido: TEdit;
    cds_itens_pedidoCOD_CLIENTE: TFloatField;
    btn_cancela_pedido: TBitBtn;
    lbl_nro_pedido: TLabel;
    q_aux: TQuery;
    procedure edt_cod_clienteKeyPress(Sender: TObject; var Key: Char);
    procedure edt_qtdeKeyPress(Sender: TObject; var Key: Char);
    procedure edt_cod_clienteExit(Sender: TObject);
    procedure edt_cod_produtoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_inserirClick(Sender: TObject);
    procedure q_produtoAfterOpen(DataSet: TDataSet);
    procedure cds_itens_pedidoAfterPost(DataSet: TDataSet);
    procedure dbg_itens_pedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cds_itens_pedidoBeforeDelete(DataSet: TDataSet);
    procedure btn_gravar_pedidoClick(Sender: TObject);
    procedure edt_cod_clienteChange(Sender: TObject);
    procedure btn_pesq_pedidoClick(Sender: TObject);
    procedure btn_cancela_pedidoClick(Sender: TObject);
  private
    { Private declarations }
    n_soma_pedido: Real;

    procedure ChecarDados;
    procedure LimparCampos;
  public
    { Public declarations }
  end;

var
  Frm_pedidos: TFrm_pedidos;

implementation

uses u_principal;

{$R *.dfm}

procedure TFrm_pedidos.LimparCampos;
begin
  edt_cod_produto.Clear;
  edt_qtde.Clear;
  edt_vlr_unitario.Clear;
  q_produto.Close;
end;

procedure TFrm_pedidos.cds_itens_pedidoAfterPost(DataSet: TDataSet);
begin
  n_soma_pedido := n_soma_pedido + cds_itens_pedido.FieldByName('VLR_TOTAL').AsFloat;

  lbl_total_pedido.Caption := '';
  lbl_total_pedido.Caption := 'Total do Pedido: R$ ' + FormatFloat('###,###,##0.00', n_soma_pedido);
end;

procedure TFrm_pedidos.cds_itens_pedidoBeforeDelete(DataSet: TDataSet);
begin
  n_soma_pedido := n_soma_pedido - cds_itens_pedido.FieldByName('VLR_TOTAL').AsFloat;

  lbl_total_pedido.Caption := '';
  lbl_total_pedido.Caption := 'Total do Pedido: R$ ' + FormatFloat('###,###,##0.00', n_soma_pedido);
end;

procedure TFrm_pedidos.ChecarDados;
begin
  if Trim(edt_cod_cliente.Text) = '' then
    begin
    ShowMessage('Informe Código do Cliente');
    edt_cod_cliente.SetFocus;
    Abort;
    end;

  if Trim(edt_cod_produto.Text) = '' then
    begin
    ShowMessage('Informe Código do Produto');
    edt_cod_produto.SetFocus;
    Abort;
    end;

  if Trim(edt_qtde.Text) = '' then
    begin
    ShowMessage('Informe Qtde. do Produto');
    edt_qtde.SetFocus;
    Abort;
    end;

  if Trim(edt_vlr_unitario.Text) = '' then
    begin
    ShowMessage('Informe Vlr. Unitário do Produto');
    edt_vlr_unitario.SetFocus;
    Abort;
    end;
end;

procedure TFrm_pedidos.dbg_itens_pedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    begin
    if MessageBox(Handle, 'Deseja realmente apagar este produto do Pedido?', 'Confirmação de operação', MB_TASKMODAL + MB_ICONQUESTION + MB_YESNO) = IDYES then
      begin
      cds_itens_pedido.Delete;
      end;
    end;

  if Key = VK_RETURN then
    begin
    edt_cod_produto.Text  := cds_itens_pedido.FieldByName('COD_PRODUTO').AsString;
    edt_qtde.Text         := cds_itens_pedido.FieldByName('QTDE').AsString;
    edt_vlr_unitario.Text := cds_itens_pedido.FieldByName('VLR_UNIT').AsString;

    cds_itens_pedido.Delete;
    edt_cod_produtoExit(Sender);
    edt_cod_produto.Enabled := False;
    end;
end;

procedure TFrm_pedidos.btn_cancela_pedidoClick(Sender: TObject);
begin
  try
  Frm_Principal.DB_HCRP.StartTransaction;
  q_aux.Close;

  //Apagar Tabela Filha
  q_aux.SQL.Text := 'DELETE FROM PEDIDOS_PRODUTOS PP WHERE PP.NRO_PEDIDO = :NRO_PEDIDO';
  q_aux.ParamByName('NRO_PEDIDO').DataType := ftFloat;
  q_aux.ParamByName('NRO_PEDIDO').AsFloat  := StrToFloat(edt_nro_pedido.Text);
  q_aux.ExecSQL;

  //Apagar Tabela Pai
  if q_aux.RowsAffected >= 1 then
    begin
    q_aux.SQL.Text := 'DELETE FROM PEDIDOS_DADOS_GERAIS PDG WHERE PDG.NRO_PEDIDO = :NRO_PEDIDO';
    q_aux.ParamByName('NRO_PEDIDO').DataType := ftFloat;
    q_aux.ParamByName('NRO_PEDIDO').AsFloat  := StrToFloat(edt_nro_pedido.Text);
    q_aux.ExecSQL;

    if Frm_Principal.DB_HCRP.InTransaction then
      Frm_Principal.DB_HCRP.Commit;
    ShowMessage('Nro. Pedido cancelado com Sucesso');
    edt_nro_pedido.Clear;
    end
  else
    begin
    Frm_Principal.DB_HCRP.Rollback;
    ShowMessage('Nro. Pedido não encontrado. Não foi possível o cancelamento');
    edt_nro_pedido.Clear;
    edt_nro_pedido.SetFocus;
    end;

  except
    on E : Exception do
       begin
       if Frm_Principal.DB_HCRP.InTransaction then
         Frm_Principal.DB_HCRP.Rollback;
       ShowMessage(E.Message);
       end;
  end;
end;

procedure TFrm_pedidos.btn_gravar_pedidoClick(Sender: TObject);
  var
    n_nro_pedido : Real;
begin
  if (cds_itens_pedido.RecordCount > 0) then
    begin
      try
      Frm_Principal.DB_HCRP.StartTransaction;

      n_nro_pedido := 0;

      q_aux.Close;
      q_aux.SQL.Text := 'SELECT COUNT(PDG.NRO_PEDIDO) CONTADOR FROM PEDIDOS_DADOS_GERAIS PDG';
      q_aux.Open;

      if q_aux.Fields[0].AsFloat = 0 then
        n_nro_pedido := 1                  //Primeiro Pedido a ser gravado - ainda não existe nenhum
      else
        begin
        //Buscar o próximo Nro de Pedido disponível (busca o MAX+1)
        q_busca_prox_nro_pedido.Close;
        q_busca_prox_nro_pedido.Open;
        n_nro_pedido := q_busca_prox_nro_pedido.FieldByName('NRO_PED_DISPONIVEL').AsFloat;
        end;


      //Gravar Tabela Pai
      q_grava_pedido.ParamByName('NRO_PEDIDO').AsFloat    := n_nro_pedido;
      q_grava_pedido.ParamByName('DATA_EMISSAO').Clear;
      q_grava_pedido.ParamByName('COD_CLIENTE').AsFloat   := StrToFloat(edt_cod_cliente.Text);
      q_grava_pedido.ParamByName('VLR_TOTAL').AsFloat     := n_soma_pedido;
      q_grava_pedido.ExecSQL;

      //Gravar Tabela Filha
      cds_itens_pedido.First;
      while not cds_itens_pedido.Eof do
        begin
        q_grava_itens_pedido.ParamByName('AUTOINCREM').Clear;
        q_grava_itens_pedido.ParamByName('NRO_PEDIDO').AsFloat  := n_nro_pedido;
        q_grava_itens_pedido.ParamByName('COD_PRODUTO').AsFloat := cds_itens_pedido.FieldByName('COD_PRODUTO').AsFloat;
        q_grava_itens_pedido.ParamByName('QTDE').AsFloat        := cds_itens_pedido.FieldByName('QTDE').AsFloat;
        q_grava_itens_pedido.ParamByName('VLR_UNIT').AsFloat    := cds_itens_pedido.FieldByName('VLR_UNIT').AsFloat;
        q_grava_itens_pedido.ParamByName('VLR_TOTAL').AsFloat   := cds_itens_pedido.FieldByName('VLR_TOTAL').AsFloat;
        q_grava_itens_pedido.ExecSQL;

        cds_itens_pedido.Next;
        end;


      if Frm_Principal.DB_HCRP.InTransaction then
        Frm_Principal.DB_HCRP.Commit;
      ShowMessage('Nro. Pedido gravado com sucesso');


      n_soma_pedido := 0;
      lbl_total_pedido.Caption := 'Total do Pedido:';
      edt_cod_cliente.Enabled := True;
      edt_cod_cliente.Text := '';
      q_cliente.Close;

      cds_itens_pedido.Close;
      q_itens_pedido.Close;
      q_itens_pedido.ParamByName('NRO_PEDIDO').AsFloat := -1;
      cds_itens_pedido.Open;

      edt_cod_cliente.SetFocus;

      except
        on E : Exception do
           begin
           if Frm_Principal.DB_HCRP.InTransaction then
             Frm_Principal.DB_HCRP.Rollback;
           ShowMessage(E.Message);
           end;
      end;
    end
  else
    ShowMessage('Nenhum Produto(s) para Gravação');
end;

procedure TFrm_pedidos.btn_inserirClick(Sender: TObject);
begin
  ChecarDados;

  if cds_itens_pedido.State in [dsBrowse] then
    begin
    cds_itens_pedido.Insert;
    cds_itens_pedido.FieldByName('COD_PRODUTO').AsFloat := StrToFloat(edt_cod_produto.Text);
    cds_itens_pedido.FieldByName('DESCRICAO').AsString  := dbe_produto.Text;
    cds_itens_pedido.FieldByName('QTDE').AsFloat        := StrToFloat(edt_qtde.Text);
    cds_itens_pedido.FieldByName('VLR_UNIT').AsFloat    := StrToFloat(edt_vlr_unitario.Text);
    cds_itens_pedido.FieldByName('VLR_TOTAL').AsFloat   := StrToFloat(edt_qtde.Text) * StrToFloat(edt_vlr_unitario.Text);
    cds_itens_pedido.Post;

    LimparCampos;
    edt_cod_produto.Enabled := True;
    edt_cod_produto.SetFocus;
    end;

  edt_cod_cliente.Enabled := False;  
end;

procedure TFrm_pedidos.btn_pesq_pedidoClick(Sender: TObject);
  var
    n_total_geral_pedido : Real;
begin
  if cds_itens_pedido.Active then
    begin
    cds_itens_pedido.Close;
    q_itens_pedido.Close;
    end;

  q_itens_pedido.ParamByName('NRO_PEDIDO').AsFloat := StrToFloat(edt_nro_pedido.Text);
  cds_itens_pedido.Open;

  if cds_itens_pedido.IsEmpty then
    begin
    ShowMessage('Nro. Pedido não encontrado');
    edt_nro_pedido.Clear;
    edt_nro_pedido.SetFocus;
    end
  else
    begin
    btn_inserir.Enabled := False;
    btn_gravar_pedido.Enabled := False;
    edt_cod_produto.Enabled := False;
    edt_qtde.Enabled := False;
    edt_vlr_unitario.Enabled := False;
    dbg_itens_pedido.Enabled := False;    

    edt_cod_cliente.Text := cds_itens_pedido.FieldByName('COD_CLIENTE').AsString;
    edt_cod_cliente.Enabled := False;
    edt_cod_clienteExit(Sender);

    //Calcular o Total Geral do Pedido
    n_total_geral_pedido := 0;
    cds_itens_pedido.First;
    while not cds_itens_pedido.Eof do
      begin
      n_total_geral_pedido := n_total_geral_pedido + cds_itens_pedido.FieldByName('VLR_TOTAL').AsFloat;
      cds_itens_pedido.Next;
      end;
    lbl_total_pedido.Caption := '';
    lbl_total_pedido.Caption := 'Total do Pedido: R$ ' + FormatFloat('###,###,##0.00', n_total_geral_pedido);
    cds_itens_pedido.First;
    end;
end;

procedure TFrm_pedidos.edt_cod_clienteChange(Sender: TObject);
begin
  btn_pesq_pedido.Visible    := edt_cod_cliente.Text = '';
  btn_cancela_pedido.Visible := edt_cod_cliente.Text = '';
  edt_nro_pedido.Visible     := edt_cod_cliente.Text = '';
  lbl_nro_pedido.Visible     := edt_cod_cliente.Text = '';
end;

procedure TFrm_pedidos.edt_cod_clienteExit(Sender: TObject);
begin
  if Trim(edt_cod_cliente.Text) <> '' then
    begin
    if q_cliente.Active then q_cliente.Close;
    q_cliente.ParamByName('CODIGO').AsFloat := StrToFloat(edt_cod_cliente.Text);
    q_cliente.Open;

    if q_cliente.FieldByName('NOME').IsNull then
      begin
      ShowMessage('Cliente não cadastrado.');
      edt_cod_cliente.SetFocus;
      end;
    end;
end;

procedure TFrm_pedidos.edt_cod_clienteKeyPress(Sender: TObject; var Key: Char);
begin
  If Not (Key In ['0'..'9', #8]) Then
    Key := #0;
end;

procedure TFrm_pedidos.edt_cod_produtoExit(Sender: TObject);
begin
  if Trim(edt_cod_produto.Text) <> '' then
    begin
    if q_produto.Active then q_produto.Close;
    q_produto.ParamByName('CODIGO').AsFloat := StrToFloat(edt_cod_produto.Text);
    q_produto.Open;

    if q_produto.FieldByName('DESCRICAO').IsNull then
      begin
      ShowMessage('Produto não cadastrado.');
      edt_cod_produto.SetFocus;
      end;
    end;
end;

procedure TFrm_pedidos.edt_qtdeKeyPress(Sender: TObject; var Key: Char);
begin
  If Not (Key In ['0'..'9', #8, ',']) Then
    Key := #0;
end;

procedure TFrm_pedidos.FormShow(Sender: TObject);
begin
  q_itens_pedido.ParamByName('NRO_PEDIDO').AsFloat := -1;
  cds_itens_pedido.Open;

  n_soma_pedido := 0;
end;

procedure TFrm_pedidos.q_produtoAfterOpen(DataSet: TDataSet);
begin
  if (edt_vlr_unitario.Text = '') and (not q_produto.FieldByName('PRECO_VENDA').IsNull) then
    edt_vlr_unitario.Text := q_produto.FieldByName('PRECO_VENDA').AsString;
end;

end.
