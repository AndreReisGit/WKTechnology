object Frm_pedidos: TFrm_pedidos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Tela de Pedidos'
  ClientHeight = 461
  ClientWidth = 985
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_topo: TPanel
    Left = 0
    Top = 0
    Width = 985
    Height = 171
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 1005
    object Label1: TLabel
      Left = 21
      Top = 25
      Width = 56
      Height = 13
      Caption = 'Cod.Cliente'
    end
    object Label2: TLabel
      Left = 91
      Top = 25
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label3: TLabel
      Left = 21
      Top = 86
      Width = 52
      Height = 13
      Caption = 'C'#243'd. Prod.'
    end
    object Label4: TLabel
      Left = 93
      Top = 86
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label5: TLabel
      Left = 509
      Top = 86
      Width = 28
      Height = 13
      Caption = 'Qtde.'
    end
    object Label6: TLabel
      Left = 589
      Top = 86
      Width = 64
      Height = 13
      Caption = 'Valor Unit'#225'rio'
    end
    object lbl_nro_pedido: TLabel
      Left = 906
      Top = 39
      Width = 56
      Height = 13
      Caption = 'Nro. Pedido'
    end
    object edt_cod_cliente: TEdit
      Left = 21
      Top = 40
      Width = 50
      Height = 21
      TabOrder = 0
      OnChange = edt_cod_clienteChange
      OnExit = edt_cod_clienteExit
      OnKeyPress = edt_cod_clienteKeyPress
    end
    object edt_cod_produto: TEdit
      Left = 21
      Top = 100
      Width = 50
      Height = 21
      TabOrder = 2
      OnExit = edt_cod_produtoExit
      OnKeyPress = edt_cod_clienteKeyPress
    end
    object edt_qtde: TEdit
      Left = 509
      Top = 100
      Width = 65
      Height = 21
      TabOrder = 4
      OnKeyPress = edt_qtdeKeyPress
    end
    object edt_vlr_unitario: TEdit
      Left = 589
      Top = 100
      Width = 81
      Height = 21
      TabOrder = 5
      OnKeyPress = edt_qtdeKeyPress
    end
    object btn_inserir: TBitBtn
      Left = 694
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Inserir +'
      TabOrder = 6
      OnClick = btn_inserirClick
    end
    object dbe_nome: TDBEdit
      Left = 91
      Top = 40
      Width = 675
      Height = 21
      Color = clBtnFace
      DataField = 'NOME'
      DataSource = ds_cliente
      ReadOnly = True
      TabOrder = 1
    end
    object dbe_produto: TDBEdit
      Left = 91
      Top = 100
      Width = 412
      Height = 21
      Color = clBtnFace
      DataField = 'DESCRICAO'
      DataSource = ds_produto
      ReadOnly = True
      TabOrder = 3
    end
    object btn_pesq_pedido: TBitBtn
      Left = 800
      Top = 50
      Width = 97
      Height = 25
      Caption = 'Pesquisar Pedido'
      TabOrder = 7
      OnClick = btn_pesq_pedidoClick
    end
    object edt_nro_pedido: TEdit
      Left = 904
      Top = 53
      Width = 60
      Height = 21
      TabOrder = 8
      OnKeyPress = edt_cod_clienteKeyPress
    end
    object btn_cancela_pedido: TBitBtn
      Left = 800
      Top = 21
      Width = 97
      Height = 25
      Caption = 'Cancelar Pedido'
      TabOrder = 9
      OnClick = btn_cancela_pedidoClick
    end
  end
  object pnl_central: TPanel
    Left = 0
    Top = 171
    Width = 985
    Height = 168
    Align = alTop
    TabOrder = 1
    ExplicitTop = 177
    ExplicitWidth = 949
    object dbg_itens_pedido: TDBGrid
      Left = 1
      Top = 1
      Width = 983
      Height = 166
      Hint = '<ENTER> ALTERA  <DEL> EXCLUI'
      Align = alClient
      DataSource = ds_itens_pedido
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = dbg_itens_pedidoKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'COD_PRODUTO'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 485
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDE'
          Title.Caption = 'Qtde.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLR_UNIT'
          Title.Caption = 'Vlr. Unit.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLR_TOTAL'
          Title.Caption = 'Vlr. Total'
          Visible = True
        end>
    end
  end
  object TPanel
    Left = 0
    Top = 339
    Width = 985
    Height = 58
    Align = alTop
    TabOrder = 2
    ExplicitLeft = 8
    ExplicitTop = 351
    ExplicitWidth = 933
    object btn_gravar_pedido: TBitBtn
      Left = 453
      Top = 16
      Width = 121
      Height = 25
      Caption = 'GRAVAR PEDIDO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btn_gravar_pedidoClick
    end
  end
  object TPanel
    Left = 0
    Top = 397
    Width = 985
    Height = 67
    Align = alTop
    TabOrder = 3
    ExplicitTop = 432
    ExplicitWidth = 1005
    object lbl_total_pedido: TLabel
      Left = 24
      Top = 24
      Width = 329
      Height = 13
      AutoSize = False
      Caption = 'Total do Pedido:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btn_sair: TBitBtn
      Left = 889
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Sair'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object ds_itens_pedido: TDataSource
    DataSet = cds_itens_pedido
    Left = 144
    Top = 248
  end
  object cds_itens_pedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_itens_pedido'
    AfterPost = cds_itens_pedidoAfterPost
    BeforeDelete = cds_itens_pedidoBeforeDelete
    Left = 184
    Top = 248
    object cds_itens_pedidoCOD_PRODUTO: TFloatField
      FieldName = 'COD_PRODUTO'
    end
    object cds_itens_pedidoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object cds_itens_pedidoQTDE: TFloatField
      FieldName = 'QTDE'
    end
    object cds_itens_pedidoVLR_UNIT: TFloatField
      FieldName = 'VLR_UNIT'
      DisplayFormat = '###,###,##0.00'
    end
    object cds_itens_pedidoVLR_TOTAL: TFloatField
      FieldName = 'VLR_TOTAL'
      DisplayFormat = '###,###,##0.00'
    end
    object cds_itens_pedidoCOD_CLIENTE: TFloatField
      FieldName = 'COD_CLIENTE'
    end
  end
  object dsp_itens_pedido: TDataSetProvider
    DataSet = q_itens_pedido
    Left = 224
    Top = 248
  end
  object q_itens_pedido: TQuery
    DatabaseName = 'db_hcrp'
    SQL.Strings = (
      'SELECT PP.COD_PRODUTO,'
      '           P.DESCRICAO,'
      '           PP.QTDE,'
      '           PP.VLR_UNIT,'
      '           PP.VLR_TOTAL,'
      '           PDG.COD_CLIENTE'
      'FROM PEDIDOS_PRODUTOS PP, PRODUTOS P, PEDIDOS_DADOS_GERAIS PDG'
      'WHERE PP.NRO_PEDIDO = :NRO_PEDIDO'
      'AND PP.COD_PRODUTO = P.CODIGO'
      'AND PP.NRO_PEDIDO = PDG.NRO_PEDIDO'
      'ORDER BY PP.COD_PRODUTO')
    Left = 256
    Top = 248
    ParamData = <
      item
        DataType = ftFloat
        Name = 'NRO_PEDIDO'
        ParamType = ptInput
      end>
  end
  object q_cliente: TQuery
    DatabaseName = 'db_hcrp'
    SQL.Strings = (
      'SELECT C.NOME'
      'FROM CLIENTES C'
      'WHERE C.CODIGO = :CODIGO')
    Left = 56
    Top = 296
    ParamData = <
      item
        DataType = ftFloat
        Name = 'CODIGO'
        ParamType = ptInput
      end>
  end
  object q_produto: TQuery
    AfterOpen = q_produtoAfterOpen
    DatabaseName = 'db_hcrp'
    SQL.Strings = (
      'SELECT P.DESCRICAO, P.PRECO_VENDA'
      'FROM PRODUTOS P'
      'WHERE P.CODIGO = :CODIGO')
    Left = 152
    Top = 296
    ParamData = <
      item
        DataType = ftFloat
        Name = 'CODIGO'
        ParamType = ptInput
      end>
  end
  object ds_cliente: TDataSource
    DataSet = q_cliente
    Left = 24
    Top = 296
  end
  object ds_produto: TDataSource
    DataSet = q_produto
    Left = 120
    Top = 296
  end
  object q_busca_prox_nro_pedido: TQuery
    DatabaseName = 'db_hcrp'
    SQL.Strings = (
      'SELECT MAX(PDG.NRO_PEDIDO)+1 NRO_PED_DISPONIVEL'
      'FROM PEDIDOS_DADOS_GERAIS PDG'
      '')
    Left = 816
    Top = 232
  end
  object q_grava_pedido: TQuery
    DatabaseName = 'db_hcrp'
    SQL.Strings = (
      'INSERT INTO PEDIDOS_DADOS_GERAIS(NRO_PEDIDO,'
      '                                 DATA_EMISSAO,'
      '                                 COD_CLIENTE,'
      '                                 VLR_TOTAL)'
      
        'VALUES(:NRO_PEDIDO, :DATA_EMISSAO, :COD_CLIENTE, :VLR_TOTAL)    ' +
        '                             ')
    Left = 816
    Top = 264
    ParamData = <
      item
        DataType = ftFloat
        Name = 'NRO_PEDIDO'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATA_EMISSAO'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'COD_CLIENTE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'VLR_TOTAL'
        ParamType = ptInput
      end>
  end
  object q_grava_itens_pedido: TQuery
    DatabaseName = 'db_hcrp'
    SQL.Strings = (
      'INSERT INTO PEDIDOS_PRODUTOS(AUTOINCREM,'
      '                             NRO_PEDIDO,'
      '                             COD_PRODUTO,'
      '                             QTDE,'
      '                             VLR_UNIT,'
      '                             VLR_TOTAL)'
      
        'VALUES(:AUTOINCREM, :NRO_PEDIDO, :COD_PRODUTO, :QTDE,  :VLR_UNIT' +
        ', :VLR_TOTAL)                             ')
    Left = 848
    Top = 264
    ParamData = <
      item
        DataType = ftFloat
        Name = 'AUTOINCREM'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NRO_PEDIDO'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'COD_PRODUTO'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'QTDE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'VLR_UNIT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'VLR_TOTAL'
        ParamType = ptInput
      end>
  end
  object q_aux: TQuery
    DatabaseName = 'db_hcrp'
    Left = 632
    Top = 288
  end
end
