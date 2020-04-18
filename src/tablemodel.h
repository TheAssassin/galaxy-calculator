#ifndef TABLEMODEL_H
#define TABLEMODEL_H

#include <QObject>
#include <QAbstractTableModel>

class TableModel : public QAbstractTableModel
{
        Q_OBJECT
        enum TableRoles
        {
            TableDataRole = Qt::UserRole + 1,
            HeadingRole
        };
    public:
        explicit TableModel(QObject *parent = nullptr);
        int rowCount(const QModelIndex & = QModelIndex()) const override;

        int columnCount(const QModelIndex & = QModelIndex()) const override;

        QVariant data(const QModelIndex &index, int role) const override;

        QHash<int, QByteArray> roleNames() const override;

        Q_INVOKABLE void insertRecord(QString msg0, QString msg1, QString msg2, QString msg3, QString msg4, QString msg5, QString msg6);
        Q_INVOKABLE void newTable();

    signals:

    public slots:
    private:
        QVector<QVector<QString>> table;
};

#endif // TABLEMODEL_H
