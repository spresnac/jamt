unit unt_filter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, dwStrings;

type
  TfrmFilter = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    lvBlacklist: TListView;
    btnBLDeleteFilter: TSpeedButton;
    btnBLEditFilter: TSpeedButton;
    btnBLNewFilter: TSpeedButton;
    cmbBLFilterType: TComboBox;
    cmbBLFilterCase: TComboBox;
    edtBLFilterText: TEdit;
    Bevel1: TBevel;
    cmbBLFilterAccount: TComboBox;
    cmbWLFilterAccount: TComboBox;
    cmbWLFilterType: TComboBox;
    cmbWLFilterCase: TComboBox;
    edtWLFilterText: TEdit;
    btnWLNewFilter: TSpeedButton;
    btnWLEditFilter: TSpeedButton;
    btnWLDeleteFilter: TSpeedButton;
    lvWhitelist: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvBlacklistClick(Sender: TObject);
    procedure btnBLDeleteFilterClick(Sender: TObject);
    procedure btnBLEditFilterClick(Sender: TObject);
    procedure btnBLNewFilterClick(Sender: TObject);
    procedure lvWhitelistClick(Sender: TObject);
    procedure btnWLDeleteFilterClick(Sender: TObject);
    procedure btnWLEditFilterClick(Sender: TObject);
    procedure btnWLNewFilterClick(Sender: TObject);
  private
    m_Blacklist   : array of String;
    m_Whitelist   : array of String;
    
    function loadBlacklist():boolean;
    function saveBlacklist():boolean;

    function loadWhitelist():boolean;
    function saveWhitelist():boolean;
    
    function getFilterData(arrListe: array of String;iFilterNo:integer;var iAccount,iActive,iType,iCase:integer;var sText:string):boolean;

  public
    function isOnThisList(arrListe: array of String; accountno: integer;date,from,subject: string):boolean;
    function isOnList(listtyp: integer; accountno: integer; date,from,subject: string):boolean;

  end;

var
  frmFilter: TfrmFilter;

implementation

uses unt_globals;

{$R *.dfm}

procedure TfrmFilter.FormCreate(Sender: TObject);
begin
    loadBlacklist();
    loadWhitelist();
end;

function TfrmFilter.getFilterData(arrListe: array of String;iFilterNo:integer;var iAccount,iActive,iType,iCase:integer;var sText:string):boolean;
var
    iPos1,iPos2,iPos3,iPos4: integer;
begin
    // Test auf Größe des Arrays
    if (iFilterNo > High(arrListe)) then
    begin
        // Rückgabe
        getFilterData := true;
    end
    else begin
        // Konto filtern
        iPos1   := dwSubPositionByIndex(arrListe[iFilterNo],';',1);
        iAccount:= StrToInt(dwStrLeft(arrListe[iFilterNo],iPos1-1));

        // Aktiv filtern
        iPos2   := dwSubPositionByIndex(arrListe[iFilterNo],';',2);
        iActive := StrToInt(dwStrMid(arrListe[iFilterNo],iPos1+1,iPos2-iPos1-1));

        // Typ filtern
        iPos3   := dwSubPositionByIndex(arrListe[iFilterNo],';',3);
        iType   := StrToInt(dwStrMid(arrListe[iFilterNo],iPos2+1,iPos3-iPos2-1));

        // Case filtern
        iPos4   := dwSubPositionByIndex(arrListe[iFilterNo],';',4);
        iCase   := StrToInt(dwStrMid(arrListe[iFilterNo],iPos3+1,iPos4-iPos3-1));

        // Text filtern
        sText   := dwStrRight(arrListe[iFilterNo],StrLen(PChar(arrListe[iFilterNo]))-iPos4);

        // Rückgabe
        getFilterData := true;
    end;
end;

function TfrmFilter.saveBlacklist():boolean;
var
    filterfile: textfile;
    i: integer;
begin
    AssignFile(filterfile,ExtractFilePath(Application.ExeName) + 'conf/blacklist.conf');
    Rewrite(filterfile);

    for i:=0 to High(m_Blacklist) do
    begin
        Writeln(filterfile,m_Blacklist[i]);
    end;

    CloseFile(filterfile);
    saveBlacklist := true;
end;

function TfrmFilter.loadBlacklist():boolean;
var
    filterfile: textfile;
    i,fh: integer;
begin

    if (not FileExists(ExtractFilePath(Application.ExeName) + 'conf/blacklist.conf')) then
    begin
        fh := FileCreate(ExtractFilePath(Application.ExeName) + 'conf/blacklist.conf');
        FileClose(fh);
    end;


    AssignFile(filterfile,ExtractFilePath(Application.ExeName) + 'conf/blacklist.conf');
    Reset(filterfile);
    i := 0;

    SetLength(m_Blacklist,0);
    while (not Eof(filterfile)) do
    begin
        SetLength(m_Blacklist,i+1);
        Readln(filterfile,m_Blacklist[i]);
        Inc(i);
    end;
    CloseFile(filterfile);
    
    loadBlacklist := true;
end;

function TfrmFilter.saveWhitelist():boolean;
var
    filterfile: textfile;
    i: integer;
begin
    AssignFile(filterfile,ExtractFilePath(Application.ExeName) + 'conf/whitelist.conf');
    Rewrite(filterfile);

    for i:=0 to High(m_Whitelist) do
    begin
        Writeln(filterfile,m_Whitelist[i]);
    end;

    CloseFile(filterfile);
    saveWhitelist := true;
end;

function TfrmFilter.loadWhitelist():boolean;
var
    filterfile: textfile;
    i,fh: integer;
begin

    if (not FileExists(ExtractFilePath(Application.ExeName) + 'conf/whitelist.conf')) then
    begin
        fh := FileCreate(ExtractFilePath(Application.ExeName) + 'conf/whitelist.conf');
        FileClose(fh);
    end;

    AssignFile(filterfile,ExtractFilePath(Application.ExeName) + 'conf/whitelist.conf');
    Reset(filterfile);
    i := 0;

    while (not Eof(filterfile)) do
    begin
        SetLength(m_Whitelist,i+1);
        Readln(filterfile,m_Whitelist[i]);
        Inc(i);
    end;
    CloseFile(filterfile);
    
    loadWhitelist := true;
end;

function TfrmFilter.isOnThisList(arrListe: array of String; accountno: integer;date,from,subject: string):boolean;
var
    i,account,active,filtertyp,filtercase:integer;
    filtertext,tmpsubject,tmpfrom,tmpstring, tmpfiltertext: string;
begin
    isOnThisList        := false;
    tmpsubject          := AnsiLowerCase(subject);
    tmpfrom             := AnsiLowerCase(from);
    for i:=0 to High(arrListe) do
    begin
        if (getFilterData(arrListe,i,account,active,filtertyp,filtercase,filtertext)) then
        begin
            tmpfiltertext       := AnsiLowerCase(filtertext);
            if (active = 1) and ((account = (accountno+1)) or (account = 0)) then
            begin
                if filtertyp = 1 then   // Betreff
                begin
                    if filtercase = 1 then // enthält
                    begin
                        if dwStringCountInStr(tmpfiltertext,tmpsubject) > 0 then
                        begin
                            isOnThisList := true;
                            Break;
                        end;
                    end;

                    if filtercase = 2 then // beginnt mit
                    begin
                        tmpstring := dwStrLeft(tmpsubject,Length(tmpfiltertext));
                        if (tmpstring = tmpfiltertext) then
                        begin
                            isOnThisList := true;
                            Break;
                        end;
                    end;

                    if filtercase = 3 then // endet mit
                    begin
                        tmpstring := dwStrRight(tmpsubject,Length(tmpfiltertext));
                        if (tmpstring = tmpfiltertext) then
                        begin
                            isOnThisList := true;
                            Break;
                        end;
                    end;
                end

                else if (filtertyp = 2) then   // Absender
                begin
                    if filtercase = 1 then // enthält
                    begin
                        if dwStringCountInStr(tmpfiltertext,tmpfrom) > 0 then
                        begin
                            isOnThisList := true;
                            Break;
                        end;
                    end;

                    if filtercase = 2 then // beginnt mit
                    begin
                        tmpstring := dwStrLeft(tmpfrom,Length(tmpfiltertext));
                        if (tmpstring = tmpfiltertext) then
                        begin
                            isOnThisList := true;
                            Break;
                        end;
                    end;

                    if filtercase = 3 then // endet mit
                    begin
                        tmpstring := dwStrRight(tmpfrom,Length(tmpfiltertext));
                        if (tmpstring = tmpfiltertext) then
                        begin
                            isOnThisList := true;
                            Break;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

function TfrmFilter.isOnList(listtyp: integer; accountno: integer;date,from,subject: string):boolean;
begin
    if (listtyp = 0) then
        isOnList := isOnThisList(m_Blacklist,accountno,date,from,subject)
    else
        isOnList := isOnThisList(m_Whitelist,accountno,date,from,subject);
end;

procedure TfrmFilter.FormShow(Sender: TObject);
var
    i:integer;
    iAccount,iActive,iType,iCase: integer;
    sText,sDisplayText: string;
begin
    // Konten eintragen
    cmbBLFilterAccount.Items.Clear;
    cmbBLFilterAccount.Items.Add('Alle Konten');
    for i:=0 to High(cls_globals.m_lAccounts) do
    begin
        cmbBLFilterAccount.Items.Add(cls_globals.m_lAccounts[i]);
    end;

    cmbWLFilterAccount.Items.Clear;
    cmbWLFilterAccount.Items.Add('Alle Konten');
    for i:=0 to High(cls_globals.m_lAccounts) do
    begin
        cmbWLFilterAccount.Items.Add(cls_globals.m_lAccounts[i]);
    end;

    // Blacklist eintragen
    lvBlacklist.Items.Clear;
    for i:=0 to High(m_Blacklist) do
    begin
        if (getFilterData(m_Blacklist,i,iAccount,iActive,iType,iCase,sText)) then
        begin
            // Aktiv?
            lvBlacklist.Items.Add;
            if (iActive = 0) then
                lvBlacklist.Items[i].Checked := false
            else
                lvBlacklist.Items[i].Checked := true;

            // Konto
            if (iAccount = 0) then
                lvBlacklist.Items[i].SubItems.Add('Alle Konten')
            else
                lvBlacklist.Items[i].SubItems.Add(cls_globals.m_lAccounts[iAccount-1]);

            // Eintrag
            case iType of
                1: sDisplayText := 'Betreff ';
                2: sDisplayText := 'Absender ';
            end;

            case iCase of
                1: sDisplayText := sDisplayText + 'enthält ';
                2: sDisplayText := sDisplayText + 'beginnt mit ';
                3: sDisplayText := sDisplayText + 'endet mit ';
            end;
            sDisplayText := sDisplayText + '"'+sText+'"';

            // Anzeigen
            lvBlacklist.Items[i].SubItems.Add(sDisplayText);
            sDisplayText := '';
        end;
    end;

    // White eintragen
    lvWhitelist.Items.Clear;
    for i:=0 to High(m_Whitelist) do
    begin
        if (getFilterData(m_Whitelist,i,iAccount,iActive,iType,iCase,sText)) then
        begin
            // Aktiv?
            lvWhitelist.Items.Add;
            if (iActive = 0) then
                lvWhitelist.Items[i].Checked := false
            else
                lvWhitelist.Items[i].Checked := true;

            // Konto
            if (iAccount = 0) then
                lvWhitelist.Items[i].SubItems.Add('Alle Konten')
            else
                lvWhitelist.Items[i].SubItems.Add(cls_globals.m_lAccounts[iAccount-1]);

            // Eintrag
            case iType of
                1: sDisplayText := 'Betreff ';
                2: sDisplayText := 'Absender ';
            end;

            case iCase of
                1: sDisplayText := sDisplayText + 'enthält ';
                2: sDisplayText := sDisplayText + 'beginnt mit ';
                3: sDisplayText := sDisplayText + 'endet mit ';
            end;
            sDisplayText := sDisplayText + '"'+sText+'"';

            // Anzeigen
            lvWhitelist.Items[i].SubItems.Add(sDisplayText);
            sDisplayText := '';
        end;
    end;
end;

procedure TfrmFilter.lvBlacklistClick(Sender: TObject);
var
    iAccount,iActive,iType,iCase: integer;
    sText: string;
begin
    if (lvBlacklist.Selected <> nil) then
    begin
        if (getFilterData(m_Blacklist,lvBlacklist.Selected.Index,iAccount,iActive,iType,iCase,sText)) then
        begin
            cmbBLFilterAccount.ItemIndex  := iAccount;
            cmbBLFilterType.ItemIndex     := iType-1;
            cmbBLFilterCase.ItemIndex     := iCase-1;
            edtBLFilterText.Text          := sText;
        end;
    end;
end;

procedure TfrmFilter.btnBLDeleteFilterClick(Sender: TObject);
var
    i:integer;
begin
    if (lvBlacklist.Selected <> nil) then
    begin
        if (MessageBox(0, 'Soll dieser Filter wirklich gelöscht werden?', 'Achtung!', MB_ICONWARNING or MB_YESNO) in [idYes]) then
        begin
            if (lvBlacklist.Selected.Index < High(m_Blacklist)) then
            begin
                for i:=lvBlacklist.Selected.Index to High(m_Blacklist)-1 do
                begin
                    m_Blacklist[i] := m_Blacklist[i+1];
                end;
            end;
            SetLength(m_Blacklist,High(m_Blacklist));
            saveBlacklist();
            loadBlacklist();
            FormShow(self);
        end;
    end;
end;

procedure TfrmFilter.btnBLEditFilterClick(Sender: TObject);
var
    sAktiv: string;
begin
    if (lvBlacklist.Selected <> nil) then
    begin
        if (cmbBLFilterAccount.ItemIndex > -1) and (cmbBLFilterType.ItemIndex > -1) and (cmbBLFilterCase.ItemIndex > -1) and (trim(edtBLFilterText.Text) <> '') then
        begin

            if (lvBlacklist.Selected.Checked) then
                sAktiv := '1'
            else
                sAktiv := '0';

            m_Blacklist[lvBlacklist.ItemIndex] :=   IntToStr(cmbBLFilterAccount.ItemIndex)+
                                                    ';'+
                                                    sAktiv+
                                                    ';'+
                                                    IntToStr(cmbBLFilterType.ItemIndex+1)+
                                                    ';'+
                                                    IntToStr(cmbBLFilterCase.ItemIndex+1)+
                                                    ';'+
                                                    edtBLFilterText.Text;
            saveBlacklist();
            FormShow(self);
        end;
    end;
end;

procedure TfrmFilter.btnBLNewFilterClick(Sender: TObject);
var
    iNewPos: integer;
begin
    if (cmbBLFilterAccount.ItemIndex > -1) and (cmbBLFilterType.ItemIndex > -1) and (cmbBLFilterCase.ItemIndex > -1) and (trim(edtBLFilterText.Text) <> '') then
    begin
        iNewPos := High(m_Blacklist);
        Inc(iNewPos);

        SetLength(m_Blacklist,iNewPos+1);
        m_Blacklist[iNewPos] :=     IntToStr(cmbBLFilterAccount.ItemIndex)+
                                                ';'+
                                                '1'+
                                                ';'+
                                                IntToStr(cmbBLFilterType.ItemIndex+1)+
                                                ';'+
                                                IntToStr(cmbBLFilterCase.ItemIndex+1)+
                                                ';'+
                                                edtBLFilterText.Text;
        saveBlacklist();
        FormShow(self);
    end;
end;

procedure TfrmFilter.lvWhitelistClick(Sender: TObject);
var
    iAccount,iActive,iType,iCase: integer;
    sText: string;
begin
    if (lvWhitelist.Selected <> nil) then
    begin
        if (getFilterData(m_Whitelist,lvWhitelist.Selected.Index,iAccount,iActive,iType,iCase,sText)) then
        begin
            cmbWLFilterAccount.ItemIndex  := iAccount;
            cmbWLFilterType.ItemIndex     := iType-1;
            cmbWLFilterCase.ItemIndex     := iCase-1;
            edtWLFilterText.Text          := sText;
        end;
    end;
end;

procedure TfrmFilter.btnWLDeleteFilterClick(Sender: TObject);
var
    i:integer;
begin
    if (lvWhitelist.Selected <> nil) then
    begin
        if (MessageBox(0, 'Soll dieser Filter wirklich gelöscht werden?', 'Achtung!', MB_ICONWARNING or MB_YESNO) in [idYes]) then
        begin
            if (lvWhitelist.Selected.Index < High(m_Whitelist)) then
            begin
                for i:=lvWhitelist.Selected.Index to High(m_Whitelist)-1 do
                begin
                    m_Whitelist[i] := m_Whitelist[i+1];
                end;
            end;
            SetLength(m_Whitelist,High(m_Whitelist));
            saveWhitelist();
            loadWhitelist();
            FormShow(self);
        end;
    end;
end;

procedure TfrmFilter.btnWLEditFilterClick(Sender: TObject);
var
    sAktiv: string;
begin
    if (lvWhitelist.Selected <> nil) then
    begin
        if (cmbWLFilterAccount.ItemIndex > -1) and (cmbWLFilterType.ItemIndex > -1) and (cmbWLFilterCase.ItemIndex > -1) and (trim(edtWLFilterText.Text) <> '') then
        begin

            if (lvWhitelist.Selected.Checked) then
                sAktiv := '1'
            else
                sAktiv := '0';

            m_Whitelist[lvWhitelist.ItemIndex] :=   IntToStr(cmbWLFilterAccount.ItemIndex)+
                                                    ';'+
                                                    sAktiv+
                                                    ';'+
                                                    IntToStr(cmbWLFilterType.ItemIndex+1)+
                                                    ';'+
                                                    IntToStr(cmbWLFilterCase.ItemIndex+1)+
                                                    ';'+
                                                    edtWLFilterText.Text;
            saveWhitelist();
            FormShow(self);
        end;
    end;
end;

procedure TfrmFilter.btnWLNewFilterClick(Sender: TObject);
var
    iNewPos: integer;
begin
    if (cmbWLFilterAccount.ItemIndex > -1) and (cmbWLFilterType.ItemIndex > -1) and (cmbWLFilterCase.ItemIndex > -1) and (trim(edtWLFilterText.Text) <> '') then
    begin
        iNewPos := High(m_Whitelist);
        Inc(iNewPos);

        SetLength(m_Whitelist,iNewPos+1);
        m_Whitelist[iNewPos] :=     IntToStr(cmbWLFilterAccount.ItemIndex)+
                                                ';'+
                                                '1'+
                                                ';'+
                                                IntToStr(cmbWLFilterType.ItemIndex+1)+
                                                ';'+
                                                IntToStr(cmbWLFilterCase.ItemIndex+1)+
                                                ';'+
                                                edtWLFilterText.Text;
        saveWhitelist();
        FormShow(self);
    end;
end;

end.
