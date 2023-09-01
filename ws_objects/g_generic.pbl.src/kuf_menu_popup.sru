$PBExportHeader$kuf_menu_popup.sru
forward
global type kuf_menu_popup from nonvisualobject
end type
end forward

global type kuf_menu_popup from nonvisualobject
end type
global kuf_menu_popup kuf_menu_popup

type variables
//
private m_popup kmenu_popup



end variables

forward prototypes
public subroutine u_popup (integer a_xpos, integer a_ypos)
end prototypes

public subroutine u_popup (integer a_xpos, integer a_ypos);//
string k_stringa=""
long k_riga=0
m_main k_menu 
w_g_tab kw_1




kw_1 = kGuf_data_base.prendi_win_attiva( )

setpointer(kkg.pointer_default)

if isvalid(kw_1) then

	//if isvalid(kmenu_popup) then destroy kmenu_popup
	//kmenu_popup = create m_popup
	
	k_menu = m_main //kw_1.ki_menu
	
//--- se non c'e' alcun menu non faccio sta roba
//	if isvalid(kw_1.menuid) then
	if isvalid(k_menu) and isvalid(kmenu_popup) then

		kmenu_popup.u_inizializza( )
	 
		kmenu_popup.m_agglista.visible = k_menu.m_finestra.m_aggiornalista.enabled
		kmenu_popup.m_t_agglista.visible = k_menu.m_finestra.m_aggiornalista.enabled
		kmenu_popup.m_stampa.visible = k_menu.m_finestra.m_fin_stampa.enabled
		kmenu_popup.m_t_stampa.visible = k_menu.m_finestra.m_fin_stampa.enabled
		kmenu_popup.m_conferma.visible = k_menu.m_finestra.m_gestione.m_fin_conferma.enabled
		kmenu_popup.m_ritorna.visible = true
		kmenu_popup.m_inserisci.visible = k_menu.m_finestra.m_gestione.m_fin_inserimento.enabled
		kmenu_popup.m_modifica.visible = k_menu.m_finestra.m_gestione.m_fin_modifica.enabled
		kmenu_popup.m_t_modifica.visible = k_menu.m_finestra.m_gestione.m_fin_modifica.enabled
		kmenu_popup.m_cancella.visible = k_menu.m_finestra.m_gestione.m_fin_elimina.enabled
		kmenu_popup.m_t_cancella.visible = k_menu.m_finestra.m_gestione.m_fin_elimina.enabled
		kmenu_popup.m_visualizza.visible = k_menu.m_finestra.m_gestione.m_fin_visualizza.enabled
		kmenu_popup.m_adatta.visible = false
	
	
		kmenu_popup.m_conferma.text = trim(k_menu.m_finestra.m_gestione.m_fin_conferma.text) //+ "  " + kmenu_popup.m_conferma.tag
		kmenu_popup.m_visualizza.text = k_menu.m_finestra.m_gestione.m_fin_visualizza.text //+ "  " + kmenu_popup.m_visualizza.tag
		kmenu_popup.m_inserisci.text = trim(k_menu.m_finestra.m_gestione.m_fin_inserimento.text) //+ "  " + kmenu_popup.m_inserisci.tag
		kmenu_popup.m_modifica.text = k_menu.m_finestra.m_gestione.m_fin_modifica.text //+ "  " + kmenu_popup.m_modifica.tag
		kmenu_popup.m_stampa.text = trim(k_menu.m_finestra.m_fin_stampa.text)
		kmenu_popup.m_cancella.text = k_menu.m_finestra.m_gestione.m_fin_elimina.text //+ "  " + kmenu_popup.m_cancella.tag
		kmenu_popup.m_adatta.text = trim(k_menu.m_finestra.m_disponi.m_adatta.text)
		kmenu_popup.m_cerca.text = trim(k_menu.m_trova.m_fin_cerca.text)
		kmenu_popup.m_filtro.text = trim(k_menu.m_trova.m_fin_filtra.text)
		kmenu_popup.m_agglista.text = trim(k_menu.m_finestra.m_aggiornalista.text)
		kmenu_popup.m_ritorna.text = k_menu.m_finestra.m_chiudifinestra.text //+ "  " + kmenu_popup.m_ritorna.tag
	
		
		kmenu_popup.m_lib_1.text = k_menu.m_strumenti.m_fin_gest_libero1.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero1.tag)
		kmenu_popup.m_lib_1.visible = (k_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero1.enabled) 
		kmenu_popup.m_lib_1.enabled = k_menu.m_strumenti.m_fin_gest_libero1.enabled
		kmenu_popup.m_lib_1.menuimage = k_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName
		kmenu_popup.m_t_lib_1.visible = kmenu_popup.m_lib_1.visible
	
		kmenu_popup.m_lib_2.text = k_menu.m_strumenti.m_fin_gest_libero2.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero2.tag)
		kmenu_popup.m_lib_2.visible = (k_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero2.enabled) 
		kmenu_popup.m_lib_2.visible = (k_menu.m_strumenti.m_fin_gest_libero2.visible or k_menu.m_strumenti.m_fin_gest_libero2.enabled)
//		if (k_menu.m_strumenti.m_fin_gest_libero2.visible or k_menu.m_strumenti.m_fin_gest_libero2.enabled) then
//			kmenu_popup.m_lib_2.visible = true
//		else
//			kmenu_popup.m_lib_2.visible = false
//		end if
//			kmenu_popup.m_lib_2.visible = true
		kmenu_popup.m_lib_2.enabled = k_menu.m_strumenti.m_fin_gest_libero2.enabled
		kmenu_popup.m_lib_2.menuimage = k_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName
		kmenu_popup.m_t_lib_2.visible = kmenu_popup.m_lib_2.visible
		
		kmenu_popup.m_lib_3.text = k_menu.m_strumenti.m_fin_gest_libero3.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero3.tag)
		kmenu_popup.m_lib_3.visible = (k_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero3.enabled) 
		kmenu_popup.m_lib_3.enabled = k_menu.m_strumenti.m_fin_gest_libero3.enabled
		kmenu_popup.m_lib_3.menuimage = k_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName
		kmenu_popup.m_t_lib_3.visible = kmenu_popup.m_lib_3.visible
		
		kmenu_popup.m_lib_4.text = k_menu.m_strumenti.m_fin_gest_libero4.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero4.tag)
		kmenu_popup.m_lib_4.visible = (k_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero4.enabled) 
		kmenu_popup.m_lib_4.enabled = k_menu.m_strumenti.m_fin_gest_libero4.enabled
		kmenu_popup.m_lib_4.menuimage = k_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName
		kmenu_popup.m_t_lib_4.visible = kmenu_popup.m_lib_4.visible
		
		kmenu_popup.m_lib_5.text = k_menu.m_strumenti.m_fin_gest_libero5.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero5.tag)
		kmenu_popup.m_lib_5.visible = (k_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero5.enabled) 
		kmenu_popup.m_lib_5.enabled = k_menu.m_strumenti.m_fin_gest_libero5.enabled
		kmenu_popup.m_lib_5.menuimage = k_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName 
		
		kmenu_popup.m_lib_6.text = k_menu.m_strumenti.m_fin_gest_libero6.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero6.tag)
		kmenu_popup.m_lib_6.visible = (k_menu.m_strumenti.m_fin_gest_libero6.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero6.enabled) 
		kmenu_popup.m_lib_6.enabled = k_menu.m_strumenti.m_fin_gest_libero6.enabled
		kmenu_popup.m_lib_6.menuimage = k_menu.m_strumenti.m_fin_gest_libero6.toolbaritemName
	
		kmenu_popup.m_lib_71.text = k_menu.m_strumenti.m_fin_gest_libero7.libero1.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero7.libero1.tag)
		kmenu_popup.m_lib_71.visible = (k_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled) 
		kmenu_popup.m_lib_71.enabled = k_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled
		kmenu_popup.m_lib_71.menuimage = k_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemName
	
		kmenu_popup.m_lib_72.text = k_menu.m_strumenti.m_fin_gest_libero7.libero2.text 
		kmenu_popup.m_lib_72.visible = (k_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled)
		kmenu_popup.m_lib_72.enabled = k_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled
		kmenu_popup.m_lib_72.menuimage = k_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemName
	
		kmenu_popup.m_lib_73.text = k_menu.m_strumenti.m_fin_gest_libero7.libero3.text 
		kmenu_popup.m_lib_73.visible = (k_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero7.libero3.enabled)
		kmenu_popup.m_lib_73.enabled = k_menu.m_strumenti.m_fin_gest_libero7.libero3.enabled
		kmenu_popup.m_lib_73.menuimage = k_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemName
	
		kmenu_popup.m_lib_74.text = k_menu.m_strumenti.m_fin_gest_libero7.libero4.text 
		kmenu_popup.m_lib_74.visible = (k_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero7.libero4.enabled)
		kmenu_popup.m_lib_74.enabled = k_menu.m_strumenti.m_fin_gest_libero7.libero4.enabled
		kmenu_popup.m_lib_74.menuimage = k_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemName
		kmenu_popup.m_t_lib_7.visible =k_menu.m_strumenti.m_fin_gest_libero7.libero1.visible
	
		kmenu_popup.m_lib_8.text = k_menu.m_strumenti.m_fin_gest_libero8.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero8.tag)
		kmenu_popup.m_lib_8.visible = (k_menu.m_strumenti.m_fin_gest_libero8.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero8.enabled)
		kmenu_popup.m_lib_8.enabled = k_menu.m_strumenti.m_fin_gest_libero8.enabled
		kmenu_popup.m_lib_8.menuimage = k_menu.m_strumenti.m_fin_gest_libero8.toolbaritemName
		kmenu_popup.m_t_lib_8.visible = k_menu.m_strumenti.m_fin_gest_libero8.visible
	
		kmenu_popup.m_lib_9.text = k_menu.m_strumenti.m_fin_gest_libero9.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero9.tag)
		kmenu_popup.m_lib_9.visible = (k_menu.m_strumenti.m_fin_gest_libero9.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero9.enabled)
		kmenu_popup.m_lib_9.enabled = k_menu.m_strumenti.m_fin_gest_libero9.enabled
		kmenu_popup.m_lib_9.menuimage = k_menu.m_strumenti.m_fin_gest_libero9.toolbaritemName
	//	kmenu_popup.m_t_lib_9.visible = k_menu.m_strumenti.m_fin_gest_libero9.visible
	
		kmenu_popup.m_lib_10.text = k_menu.m_strumenti.m_fin_gest_libero10.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero10.tag)
		kmenu_popup.m_lib_10.visible = (k_menu.m_strumenti.m_fin_gest_libero10.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero10.enabled)
		kmenu_popup.m_lib_10.enabled = k_menu.m_strumenti.m_fin_gest_libero10.enabled
		kmenu_popup.m_lib_10.menuimage = k_menu.m_strumenti.m_fin_gest_libero10.toolbaritemName
	//	kmenu_popup.m_t_lib_10.visible = k_menu.m_strumenti.m_fin_gest_libero10.visible
	
	
	//=== Attivo il menu Popup
		kmenu_popup.visible = true
		a_xpos += kw_1.x
		a_ypos += kw_1.y
		kmenu_popup.popmenu(a_xpos, a_ypos)
		
		if isvalid(kmenu_popup) then
			kmenu_popup.visible = false
		end if
		//destroy kmenu_popup
	

	end if
end if

end subroutine

on kuf_menu_popup.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_menu_popup.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//=== Creo menu Popup 
	kmenu_popup = create m_popup

end event

event destructor;//
	if isvalid(kmenu_popup) then destroy kmenu_popup

end event

