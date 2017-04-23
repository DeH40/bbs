CKEDITOR.editorConfig = function( config )
{
//config.language = 'zh-cn';         
//config.tabSpaces = 4;               
//config.resize_maxWidth = 600;             //如果设置了编辑器可以拖拽 这是可以移动的最大宽度
//config.toolbarCanCollapse = false;              //工具栏可以隐藏
//config.toolbarLocation = 'bottom';              //可选：设置工具栏在整个编辑器的底部bottom
//config.resize_minWidth = 600;                   //如果设置了编辑器可以拖拽 这是可以移动的最小宽度
//config.resize_enabled = false;                  //如果设置了编辑器可以拖拽

//config.startupFocus = true;
//config.smiley_images = ['1.gif','2.gif'];

//我设置的表情 对应要把表情文件夹的图像改过来

//设置编辑器里字体下拉列表里的字体
//config.font_names= '宋体;黑体;楷体_GB2312;Arial;Comic Sans MS;Courier New;Tahoma;Times New Roman;Verdana' ;

	config.uiColor =  '#CCCCCC';
	config.extraPlugins = 'image2,widget,smiley,font,codesnippet';
	    /*richcombo,panel,floatpanel,listblock,lineutils,widgetselection,uploadimage,uploadwidget,filetools,notificationaggregator,notification,toolbar,button  */
	config.removeButtons = 'Cut,Copy,Paste,Anchor,Link,Unlink,Indent,Outdent,Scayt,About,Format';
	   
	
	config.font_names  = '宋体;黑体;楷体_GB2312;Times New Roman;微软雅黑;Consola;Arial;Comic Sans MS;Courier New;Tahoma;Verdana';
	config.fontSize_defaultLabel = '16px';
	config.filebrowserImageUploadUrl  = "upload";
	config.tabSpaces = 4;
};