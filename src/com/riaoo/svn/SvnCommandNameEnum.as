package com.riaoo.svn
{
	public class SvnCommandNameEnum
	{
		/**
		 * add: 把文件和目录纳入版本控制，通过调度加到版本库。它们会在下一次提交时加入。
		 */		
		public static const ADD:String = "add";
		
		/**
		 * blame (praise, annotate, ann): 输出指定文件或URL的追溯内容，包含版本和作者信息。
		 */		
//		public static const BLAME:String = "blame";
		
		/**
		 * cat: 输出指定文件或URL的内容。
		 */		
//		public static const CAT:String = "cat";
		
		/**
		 * changelist (cl): 耦合(或解耦)文件与修改列表 CLNAME。
		 */		
//		public static const CHANGE_LIST:String = "changelist";
		
		/**
		 * checkout (co): 从版本库签出工作副本。
		 */		
		public static const CHECKOUT:String = "checkout";
		
		/**
		 * cleanup: 递归清理工作副本，删除锁，继续未完成操作，等等。
		 */		
//		public static const CLEANUP:String = "cleanup";
		
		/**
		 * commit (ci): 把工作副本的修改提交到版本库。
		 */		
		public static const COMMIT:String = "commit";
		
		/**
		 * copy (cp): 在工作副本或版本库中复制数据，保留历史。
		 */		
//		public static const COPY:String = "copy";
		
		/**
		 * delete (del, remove, rm): 从版本库中删除文件和目录。
		 */		
		public static const DELETE:String = "delete";
		
		/**
		 * diff (di): 显示两个版本或路径的差异。
		 */		
//		public static const DIFF:String = "diff";
		
		/**
		 * export: 产生一个无版本控制的目录树副本。
		 */		
//		public static const EXPORT:String = "export";
		
		/**
		 * help (?, h): 描述本程序或其子命令的用法。
		 */		
//		public static const HELP:String = "help";
		
		/**
		 * import: 将未纳入版本控制的文件或目录树提交到版本库。
		 */		
//		public static const IMPORT:String = "import";
		
		/**
		 * info: 显示本地或远程条目的信息。
		 */		
		public static const INFO:String = "info";
		
		/**
		 * list (ls): 列出版本库中的目录内容。
		 */		
		public static const LIST:String = "list";
		
		/**
		 * lock: 锁定版本库中的路径，使得其他用户不能向其提交修改。
		 */		
		public static const LOCK:String = "lock";
		
		/**
		 * log: 显示一组版本与/或文件的提交日志信息。
		 */		
		public static const LOG:String = "log";
		
		/**
		 * merge: 将两个源差异应用至工作副本。
		 */		
//		public static const MERGE:String = "merge";
		
		/**
		 * mergeinfo: 显示合并的相关信息。
		 */		
//		public static const MERGE_INFO:String = "mergeinfo";
		
		/**
		 * mkdir: 创建纳入版本控制的新目录。
		 */		
		public static const MK_DIR:String = "mkdir";
		
		
		/**
		 * move (mv, rename, ren): 在工作副本或版本库中移动或改名文件或目录。
		 */		
//		public static const MOVE:String = "move";
		
		
		/**
		 * propdel (pdel, pd): 删除目录、文件或版本的属性。
		 */		
//		public static const PROP_DEL:String = "propdel";
		
		
		/**
		 * propedit (pedit, pe): 使用外部编辑器编辑属性。
		 */		
//		public static const PROP_EDIT:String = "propedit";
		
		
		/**
		 * propget (pget, pg): 显示目录、文件或版本的属性取值。
		 */		
//		public static const PROP_GET:String = "propget";
		
		
		/**
		 * proplist (plist, pl): 列出目录、文件或版本的所有属性。
		 */		
//		public static const PROP_LIST:String = "proplist";
		
		
		/**
		 * propset (pset, ps): 设定目录、文件或版本的属性。
		 */		
//		public static const PROP_SET:String = "propset";
		
		
		/**
		 * resolve: 解决工作副本中目录或文件的冲突。
		 */		
//		public static const RESOLVE:String = "resolve";
		
		
		/**
		 * resolved: 删除工作副本中目录或文件的“冲突”状态。
		 */		
//		public static const RESOLVED:String = "resolved";
		
		/**
		 * revert: 将工作副本文件恢复到原始版本(恢复大部份的本地修改)。
		 */		
		public static const REVERT:String = "revert";
		
		/**
		 * status (stat, st): 显示工作副本中目录与文件的状态。
		 */		
		public static const STATUS:String = "status";
		
		/**
		 * switch (sw): 更新工作副本至不同的 URL。
		 */		
//		public static const SWITCH:String = "switch";
		
		/**
		 * unlock: 解除工作副本或URL的锁定。
		 */		
		public static const UNLOCK:String = "unlock";
		
		/**
		 * update (up): 将版本库的修改合并到工作副本中。
		 */		
		public static const UPDATE:String = "update";
		
		public function SvnCommandNameEnum()
		{
		}
	}
}