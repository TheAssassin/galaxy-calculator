#include <QDebug>
#include "tablemodel.h"
/*** **************************************************************************
 * TableModel Constructor
 */
TableModel::TableModel(QObject *parent) : QAbstractTableModel(parent)
{
    newTable();
}
/*** **************************************************************************
 * Number of rows
 */
int TableModel::rowCount(const QModelIndex &) const
{
    return table.size();
}
/*** **************************************************************************
 * Columns
 */
int TableModel::columnCount(const QModelIndex &) const
{
    return table.at(0).size();
}
/*** **************************************************************************
 * data
 */
QVariant TableModel::data(const QModelIndex &index, int role) const
{
    switch (role)
    {
        case TableDataRole:
        {
            return  table.at(index.row()).at(index.column());
        }
        case HeadingRole:
        {
            return index.row() == 0;
        }
        default:
            break;
    }
    return QVariant();
}
/*** **************************************************************************
 * roleNames
 */
QHash<int, QByteArray> TableModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TableDataRole] = "tabledata";
    roles[HeadingRole] = "heading";
    return roles;
}
/*** **************************************************************************
 * Insert Record
 */
void TableModel::insertRecord(QString msg0, QString msg1, QString msg2, QString msg3, QString msg4, QString msg5, QString msg6)
{
    //qDebug() << "c++ msgx: " << msg0 << msg1 << msg2 << msg3 << msg4 << msg5 << msg6;
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    //table.append({"666", "333", "666,666", "333,333", "6.666", "1,011,954,093,357,316,200", "30,000,030"});
    table.append({msg0, msg1, msg2, msg3, msg4, msg5, msg6});
    endInsertRows();
}
/*** **************************************************************************
 * New Table
 */
void TableModel::newTable()
{
    table.clear();
    table.append({"Track", "Trinary Engines", "Max", "Min", "Frequency", "Distance", "Track Frequency"});
}
/* ***************************** End of File ******************************* */

