/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	/*config.uiColor =  '#000000';*/
	config.extraPlugins = 'dialog,clipboard,autolink,dialogui,image2,widget,smiley,font,richcombo,panel,floatpanel,listblock,lineutils,widgetselection,uploadimage,uploadwidget,filetools,notificationaggregator,notification,toolbar,button,codesnippet';
    /*richcombo,panel,floatpanel,listblock,lineutils,widgetselection,uploadimage,uploadwidget,filetools,notificationaggregator,notification,toolbar,button  */
	config.removeButtons = 'Cut,Copy,Paste,Anchor,Unlink,Indent,Outdent,Scayt,About,Format';
	   
	
	config.font_names  = '宋体;黑体;楷体_GB2312;Times New Roman;微软雅黑;Consola;Arial;Comic Sans MS;Courier New;Tahoma;Verdana';
	config.fontSize_defaultLabel = '16px';
	config.filebrowserImageUploadUrl  = "upload";
	config.tabSpaces = 4;
};
